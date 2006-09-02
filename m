Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbWIBBAS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWIBBAS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 21:00:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWIBBAS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 21:00:18 -0400
Received: from rrcs-24-227-114-150.se.biz.rr.com ([24.227.114.150]:13700 "EHLO
	sleekfreak.ath.cx") by vger.kernel.org with ESMTP id S1750773AbWIBBAP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 21:00:15 -0400
Date: Fri, 1 Sep 2006 20:57:51 -0400 (EDT)
From: shogunx <shogunx@sleekfreak.ath.cx>
To: Matthias Hentges <oe@hentges.net>
cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not
 easily reproducable
In-Reply-To: <1157158391.20509.4.camel@mhcln03>
Message-ID: <Pine.LNX.4.44.0609012057230.8350-100000@sleekfreak.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Sep 2006, Matthias Hentges wrote:

> Am Freitag, den 01.09.2006, 20:41 +0200 schrieb Thomas Glanzmann:
> > Hello,
> > my sky2 network card in my intel mac mini just stopped working again on
> > me. After a reboot it worked again. This time there is no dmesg output
> > related to the problem. :-( Am I the only one who sees that?
>
> Nope, same here on an Asus P5W DH Deluxe mainboard. The sky2 NIC just
> silently dies after some time. Rmmod + modprobe sky2 used to re-enable
> the NIC IIRC. Since this bug makes the driver practically unusable I
> have since switched to a PCI NIC (which is a shame considering the 2
> gigabit sky2 NICs on the mainboard...).

Has this not been fixed in the 2.6.18 git?

>
>
> --
> Matthias 'CoreDump' Hentges
>
> Webmaster of hentges.net and OpenZaurus developer.
> You can reach me in #openzaurus on Freenode.
>
> My OS: Debian SID. Geek by Nature, Linux by Choice
>

sleekfreak pirate broadcast
http://sleekfreak.ath.cx:81/


-- 
VGER BF report: H 0
