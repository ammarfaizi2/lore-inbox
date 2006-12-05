Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936389AbWLEWXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936389AbWLEWXd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936571AbWLEWXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:23:33 -0500
Received: from ns2.suse.de ([195.135.220.15]:37760 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936389AbWLEWXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:23:32 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: "Marty Leisner" <linux@rochester.rr.com>, <linux-kernel@vger.kernel.org>,
       <bug-cpio@gnu.org>
Subject: Re: ownership/permissions of cpio initrd
References: <556445368AFA1C438794ABDA8901891C03445640@usa0300ms03.na.xerox.net>
X-Yow: ..  Should I get locked in the PRINCIPAL'S OFFICE today --
 or have a VASECTOMY??
Date: Tue, 05 Dec 2006 23:23:22 +0100
In-Reply-To: <556445368AFA1C438794ABDA8901891C03445640@usa0300ms03.na.xerox.net>
	(Martin Leisner's message of "Tue, 5 Dec 2006 16:56:26 -0500")
Message-ID: <jed56y0yp1.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Leisner, Martin" <Martin.Leisner@xerox.com> writes:

> hmmm...I looked at that -- that's extract and passthrough, but not create...

No, it's copy-out and copy-pass.  It does not make sense for copy-in.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
