Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932138AbWETG6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbWETG6e (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 02:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWETG6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 02:58:34 -0400
Received: from bsamwel.xs4all.nl ([82.92.179.183]:36572 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S932138AbWETG6e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 02:58:34 -0400
Message-ID: <446EBDB3.2050401@samwel.tk>
Date: Sat, 20 May 2006 08:56:51 +0200
From: Bart Samwel <bart@samwel.tk>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: =?ISO-8859-1?Q?=22D=F6hr=2C_Markus_ICC-H=22?= 
	<Markus.Doehr@siegenia-aubi.com>,
       "'Peter Gordon'" <codergeek42@gmail.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: replacing X Window System !
References: <FC7F4950D2B3B845901C3CE3A1CA6766333F93@mxnd200-9.si-aubi.siegenia-aubi.com> <Pine.LNX.4.62.0605191801020.2828@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.62.0605191801020.2828@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: bart@samwel.tk
X-SA-Exim-Scanned: No (on samwel.tk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> On Sat, 20 May 2006, "Döhr, Markus ICC-H" wrote:
> 
>> Date: Sat, 20 May 2006 02:57:55 +0200
>> From: "\"Döhr, Markus ICC-H\"" <Markus.Doehr@siegenia-aubi.com>
>> Did you actually do that? Starting Firefox over a 6 Mbit VPN takes 
>> about 3
>> minutes on a FAST machine. That´s not acceptable - our users want 
>> (almost)
>> immediate response to an application, to clicking and waiting 10 seconds
>> until the app is doing something.
> 
> this is due to the latency, not the speed (X by default requires many 
> round-trips to startup). There is an extention that greatly reduces the 
> number of round-trips nessasary, I'm willing to bet this will make a 
> huge difference for your startup. Unfortunantly I don't remember what 
> this is.

I think it's called "lbxproxy".

Cheers,
Bart
