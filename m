Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbVCWIXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbVCWIXD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 03:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262868AbVCWIXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 03:23:03 -0500
Received: from main.gmane.org ([80.91.229.2]:8664 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262869AbVCWIWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 03:22:46 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: dmesg verbosity [was Re: AGP bogosities]
Date: Wed, 23 Mar 2005 09:19:11 +0100
Message-ID: <MPG.1cab44ebc4a058a3989717@news.gmane.org>
References: <16944.62310.967444.786526@cargo.ozlabs.ibm.com> <Pine.LNX.4.62.0503140026360.10211@qynat.qvtvafvgr.pbz> <20050314083717.GA19337@elf.ucw.cz> <200503140855.18446.jbarnes@engr.sgi.com> <20050314191230.3eb09c37.diegocg@gmail.com> <1110827273.14842.3.camel@mindpipe> <20050323013729.0f5cd319.diegocg@gmail.com> <1111539217.4691.57.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-11-253.37-151.net24.it
User-Agent: MicroPlanet-Gravity/2.70.2067
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Yup, many people on this list seem unaware but read the XP white papers,
> then try booting it side by side with Linux.  They put some serious,
> serious engineering into that problem and came out with a big win.
> Screw Longhorn, we need improve by 50% to catch up to what they can do
> NOW.
> 
> The solution is fairly well known.  Rather than treating the zillions of
> disk seeks during the boot process as random unconnected events, you
> analyze the I/O done during the boot process, then lay out those disk
> blocks optimally based on this information so on the next boot you just
> do one big streaming read.  The patent side has been discussed and there
> seems to be plenty of prior art.
> 
> Someone needs to just do it.  All the required information is right
> there.

Hm. My previous WinXP box (this same machine, different hard 
disk) was VERY fast in booting WinXP, out of the box. After two 
years of usage, installations, uninstallations and whatnot it 
had become slow as molasses. The Linux installation on the SAME 
machine was not affected.

-- 
Giuseppe "Oblomov" Bilotta

Can't you see
It all makes perfect sense
Expressed in dollar and cents
Pounds shillings and pence
                  (Roger Waters)

