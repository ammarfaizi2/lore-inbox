Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWJQVF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWJQVF4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWJQVF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:05:56 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:27307 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750723AbWJQVFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:05:55 -0400
Date: Tue, 17 Oct 2006 23:05:54 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Greg.Chandler@wellsfargo.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Touchscreen hardware hacking/driver hacking.
Message-ID: <20061017210554.GA8321@rhlx01.fht-esslingen.de>
References: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E8C008223DD5F64485DFBDF6D4B7F71D020C5E83@msgswbmnmsp25.wellsfargo.com>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Oct 17, 2006 at 03:30:43PM -0500, Greg.Chandler@wellsfargo.com wrote:
> I would have posted this to a different group but there is no "input"
> mailing list.

Your posting was probably missing the Dmitry Torokhov CC (input guru,
as can be seen in MAINTAINERS).

> Reward defined:
>   Permanent shell access to my personal development envirnoment for
> testing kernel code.
>   Equipment in the environment: ARM, Alpha, x86-32, MIPS/Origin, HPPA,
> SPARC, PPC

Oh, interesting stuff. Thus let me try a cheap shot at this reward ;-):
did you run Windows driver debug message monitors (VxDMon or so)
to go fishing for some suspicious/insightful driver activities?

A last desperate resort might be running some Windows plug'n play
device viewers which might tell you more than the usual dull
Windows environment stuff.

But I'm most likely not telling you any cool new things anyway...

Andreas Mohr
