Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266695AbUFYUu4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266695AbUFYUu4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 16:50:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266704AbUFYUuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 16:50:55 -0400
Received: from zork.zork.net ([64.81.246.102]:33493 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S266695AbUFYUuq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 16:50:46 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <6uoen71pky.fsf@zork.zork.net>
	<40DC71E8.3020403@techsource.com>
	<200406252252.47266.rjwysocki@sisk.pl>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Fri, 25 Jun 2004 21:50:43 +0100
In-Reply-To: <200406252252.47266.rjwysocki@sisk.pl> (R. J. Wysocki's message
	of "Fri, 25 Jun 2004 22:52:47 +0200")
Message-ID: <6u8yeb1hwc.fsf@zork.zork.net>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: sneakums@zork.net
X-SA-Exim-Scanned: No (on zork.zork.net); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> writes:

> I think that the good reason for keeping both ext* code bases in the kernel 
> tree is that _there_ _are_ _some_ people who will need ext2 for some 
> purposes, so why should we pull the carpet from under them?

An ext3 that supports no-journal operation can surely register itself
as both ext2 and ext3 and leave userspace none the wiser.

I don't think anybody wants to pull any carpets out from under anyone.
