Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264683AbUEPR4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264683AbUEPR4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 13:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbUEPR4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 13:56:09 -0400
Received: from av8-2-sn2.hy.skanova.net ([81.228.8.111]:41183 "EHLO
	av8-2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S264683AbUEPR4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 13:56:06 -0400
X-Mailer: exmh version 2.6.3 04/02/2003 (gentoo 2.6.3) with nmh-1.1
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] Synaptics driver is 'jumpy' 
In-Reply-To: Message from Alexander Bruder <anib@uni-paderborn.de> 
   of "Sun, 16 May 2004 17:02:10 +0200." <40A78272.4020404@uni-paderborn.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 16 May 2004 19:55:38 +0200
From: aeriksson@fastmail.fm
Message-Id: <20040516175539.075544137@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> > The fact is, it worked _perfectly_ under 2.6.5 with the standard mode. No 
> > problems whatsoever. Something must have changed (but I'm too unfamiliar with 
> > kernel code) that causes some sort of a delay in the processing of the input 
> > queue of the touchpad. 
> 
> same problem here with 2.6.6 (recent gentoo system). I am running 
> 2.6.6-rc3 and 2.6.5 without the problems.
> 


fwiw, I have the same observation moving from 2.6.5-mm4 -> 2.6.6 on a
gentoo machine... On the observations side, i can add that it not
only fails to smoothly follow the track it should, but it seems it's
back to its old bad behavior of randomly jumping to the top-right
corner of the screen... :-(


/Anders


