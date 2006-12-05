Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968218AbWLEUaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968218AbWLEUaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 15:30:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968658AbWLEUaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 15:30:52 -0500
Received: from ns2.suse.de ([195.135.220.15]:59193 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968218AbWLEUav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 15:30:51 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Marty Leisner" <linux@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, bug-cpio@gnu.org, martin.leisner@xerox.com
Subject: Re: ownership/permissions of cpio initrd
References: <200612051720.kB5HKU4i001616@dell2.home>
X-Yow: Let's all show human CONCERN for REVEREND MOON's legal difficulties!!
Date: Tue, 05 Dec 2006 21:30:40 +0100
In-Reply-To: <200612051720.kB5HKU4i001616@dell2.home> (Marty Leisner's message
	of "Tue, 05 Dec 2006 12:20:30 -0500")
Message-ID: <jehcwa13wv.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Marty Leisner" <linux@rochester.rr.com> writes:

> Since a cpio is just a userspace created string of bits, I suppose
> you can apply a set of ownership/permissions to files IN the archive
> by playing with the bits...

  -R, --owner=[USER][:.][GROUP]   Set the ownership of all files created to the
                             specified USER and/or GROUP

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
