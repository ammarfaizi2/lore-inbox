Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUAKFrL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 00:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265775AbUAKFrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 00:47:10 -0500
Received: from main.gmane.org ([80.91.224.249]:40896 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265772AbUAKFrH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 00:47:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Andres Salomon <dilinger@voxel.net>
Subject: Re: rtl8180l status ?
Date: Sun, 11 Jan 2004 00:47:04 -0500
Message-ID: <pan.2004.01.11.05.47.02.88943@voxel.net>
References: <200401102054.53387.geekassault@planetinternet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if jgarzik is working on a driver or not (he never
responded to an email I sent), but I'm working on one.  The main
remaining issues I need to work on are figuring out the tx/rx buffer
management scheme the rtl8180 uses, and getting the wireless stuff
done (this is my first attempt at dealing w/ wireless nics, so associating
w/ an access point and other such things are new to me).

Unfortunately, I really have been short of time lately, so progress on the
driver has been slow.


On Sat, 10 Jan 2004 20:56:01 +0100,
Geek Assault wrote:

> hi,
> 
> I recently got my hands on a system with a realtek 8180l-based wireless 
> network card (billionton miwlrp, [1]). There is a closed source driver from 
> realtek, however it does not support 2.6 (yet, probably) and seems to be 
> quite buggy.
> 
> Having read a thread [2] about this, in which mr. Jeff Garzik seemed to imply 
> that he was working with the realtek people to create an open source driver, 
> I was wondering if anybody could confirm the existance of such an initiative.
> If it exists I'd like to offer my help, both towards developping (I'm a 
> newbie, but I'd be happy to learn :) and/or testing.
> 
> thanks in advance
> 
> [1]  http://sup.nl.packardbell.be/pri/
> index.php?PibItemNr=spec_WL_BilliontonMIWLRP
> [2]  http://groups.google.com/
> groups?hl=en&lr=&ie=UTF-8&oe=utf-8&c2coff=1&threadm=Heux.4nY.7%
> 40gated-at.bofh.it&rnum=1&prev=/groups%3Fhl%3Den%26lr%3D%26ie%3DUTF-8%26oe%
> 3Dutf-8%26c2coff%3D1%26q%3D8180%2Bgarzik%26btnG%3DGoogle%2BSearch


