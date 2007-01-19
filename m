Return-Path: <linux-kernel-owner+w=401wt.eu-S965144AbXASN6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbXASN6d (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 08:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965147AbXASN6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 08:58:33 -0500
Received: from mail.suse.de ([195.135.220.2]:52712 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965144AbXASN6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 08:58:32 -0500
From: Andreas Schwab <schwab@suse.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
	<jefya7jfxi.fsf@sykes.suse.de>
	<Pine.LNX.4.64.0701190846480.25561@CPE00045a9c397f-CM001225dbafb6>
X-Yow: I've gotta GO, now!!  I wanta tell you you're a GREAT bunch of guys
 but you ought to CHANGE your UNDERWEAR more often!!
Date: Fri, 19 Jan 2007 14:58:31 +0100
In-Reply-To: <Pine.LNX.4.64.0701190846480.25561@CPE00045a9c397f-CM001225dbafb6>
	(Robert P. J. Day's message of "Fri, 19 Jan 2007 08:48:40 -0500
	(EST)")
Message-ID: <jeejprnmns.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Robert P. J. Day" <rpjday@mindspring.com> writes:

> but in terms of strict C89 compatibility, it would seem to be a bit
> late for that given:
>
>   $ grep -r "static inline " .
>
> no?

The kernel does not use strict C89, it uses GNUC89.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
