Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317968AbSGWGfH>; Tue, 23 Jul 2002 02:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317970AbSGWGfH>; Tue, 23 Jul 2002 02:35:07 -0400
Received: from [196.26.86.1] ([196.26.86.1]:48072 "HELO
	infosat-gw.realnet.co.sz") by vger.kernel.org with SMTP
	id <S317968AbSGWGfG>; Tue, 23 Jul 2002 02:35:06 -0400
Date: Tue, 23 Jul 2002 08:56:05 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: "Craig I. Hagan" <hagan@cih.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: APIC issues with 2.4.19-rcX-acY
In-Reply-To: <Pine.LNX.4.44.0207221058320.20806-100000@svr.cih.com>
Message-ID: <Pine.LNX.4.44.0207230855100.32636-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jul 2002, Craig I. Hagan wrote:

> I've seen the following error when booting a dell 2550 (dual p3, serverworks  
> CNB20HE chipset):
> 
> APIC error on CPU0: 08(08)
> (repeats until i hard reset the machine)
> 
> I've seen this for every combination of 2.4.19-rc/ac patch that i've tried,
> however the 2.4.19-rc kernels work fine (my test system is currently running
> 2.4.19-rc3). I'd like to help resolve this issue, but I'm not quite sure as to
> where to start save rolling back all of the apic deltas in the -ac patch
> series.

Alan i might have an idea to other odd breakage, its to do with APIC 
addressing. Let me gather the info i have and i'll email it to you.

Cheers,
	Zwane
-- 
function.linuxpower.ca

