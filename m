Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbUEVNaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbUEVNaG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 09:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUEVNaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 09:30:06 -0400
Received: from pa103.nowa-wies.sdi.tpnet.pl ([213.77.149.103]:531 "EHLO
	pa103.nowa-wies.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id S261206AbUEVNaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 09:30:02 -0400
Date: Sat, 22 May 2004 15:29:38 +0200 (CEST)
From: Jan Meizner <jm@pa103.nowa-wies.sdi.tpnet.pl>
To: system <system@eluminoustechnologies.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hda Kernel error!!!
In-Reply-To: <200405221257.28570.system@eluminoustechnologies.com>
Message-ID: <Pine.LNX.4.55L.0405221515410.32669@pa103.nowa-wies.sdi.tpnet.pl>
References: <200405221257.28570.system@eluminoustechnologies.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 22 May 2004, system wrote:

> Hello All,
>  In that I found warning about kernel error!!
> 
> WARNING:  Kernel Errors Present
>    hda: drive_cmd: error=0x04 { DriveStat...:  1Time(s)
>    hda: drive_cmd: status=0x51 { DriveReady SeekComplete Error }...:  1Time(s)
> 
> What is this error?
> Dose this indicate error on hda?
> Should I replace hda?OR it's different from all these?
> Please help thank you...

Mayby I'm not kernel expert yet, but IMVHO it looks like hardware (hard 
drive) problem. 
You could do some tests on this drive using programs like badblocks or 
similar. I have problem like that and in this case it was hardware 
problem (drive had guarantee, and manufactor replaced it, so it had to be broken).
So AFAIK this type of error indicates serious problem with hardware, 
unfortunately.
Is there in logs any other similar messages in the neighbourhood of these, 
you write here?

Best Regards,
Jan Meizner
jm@jm.one.pl


