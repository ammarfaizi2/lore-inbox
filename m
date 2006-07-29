Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbWG2W2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbWG2W2l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWG2W2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 18:28:41 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:16287 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750728AbWG2W2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 18:28:40 -0400
Message-ID: <44CBE0F5.3050201@melbourne.sgi.com>
Date: Sun, 30 Jul 2006 08:28:05 +1000
From: David Chatterton <chatz@melbourne.sgi.com>
Reply-To: chatz@melbourne.sgi.com
Organization: SGI
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>, Christian Kujau <evil@g-house.de>,
       linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS breakage in 2.6.18-rc1
References: <20060718222941.GA3801@stargate.galaxy> <20060719085731.C1935136@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607221722500.8407@prinz64.housecafe.de> <20060724090138.C2083275@wobbly.melbourne.sgi.com> <Pine.LNX.4.64.0607281526220.1882@sheep.housecafe.de> <20060729074803.A2222647@wobbly.melbourne.sgi.com> <20060729202223.GD20039@charite.de>
In-Reply-To: <20060729202223.GD20039@charite.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Ralf Hildebrandt wrote:
> * Nathan Scott <nathans@sgi.com>:
> 
>> Barry sent an xfs_repair patch to resolve this issue to the xfs@oss.sgi.com
>> list yesterday; please give that a go and let us know how it fares.
> 
> Just to let you know, I did a cvs checkout of xfs-cmds
> as described on http://oss.sgi.com/projects/xfs/source.html
> 
> Then I saved the patch from
> http://oss.sgi.com/archives/xfs/2006-07/msg00374.html using the
> "Original" link on hat page.
> 
> I build a xfs_Repair binary using that, transferred it onto an old
> KLAX boot cd I had and repaired the XFS root on my laptop.
> 
> I got 5000 files in lost and found, mostly the whole manpages from my
> system. Had to reinstall a few packages to restore lost binaries, but
> that's all.
> 
> When will that horrible bug be fixed in 2.6.x? 
> 

The bug is fixed in 2.6.17.7.

David
