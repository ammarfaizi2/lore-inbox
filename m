Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWDEWFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWDEWFN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 18:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbWDEWFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 18:05:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:37504 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932097AbWDEWFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 18:05:11 -0400
From: Andreas Schwab <schwab@suse.de>
To: Kristis Makris <kristis.makris@asu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Issues with symbol names
References: <1144268838.8306.16.camel@syd.mkgnu.net>
X-Yow: I am NOT a nut....
Date: Thu, 06 Apr 2006 00:05:09 +0200
In-Reply-To: <1144268838.8306.16.camel@syd.mkgnu.net> (Kristis Makris's
	message of "Wed, 05 Apr 2006 13:27:17 -0700")
Message-ID: <jeirpn7k6i.fsf@sykes.suse.de>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristis Makris <kristis.makris@asu.edu> writes:

> My goal here is to use /proc/kallsyms to determine the size of a function
> image at runtime.

The size is also recorded in the symbol table.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
