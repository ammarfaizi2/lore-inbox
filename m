Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSAWIKf>; Wed, 23 Jan 2002 03:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289729AbSAWIKP>; Wed, 23 Jan 2002 03:10:15 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:64755 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S289727AbSAWIKM>; Wed, 23 Jan 2002 03:10:12 -0500
Message-Id: <200201222210.g0MMANwH001411@tigger.cs.uni-dortmund.de>
To: jan.ciger@epfl.ch
cc: Samuel Maftoul <maftoul@esrf.fr>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: umounting 
In-Reply-To: Message from Jan Ciger <jan.ciger@epfl.ch> 
   of "Tue, 22 Jan 2002 15:52:07 +0100." <m16T2IB-02103HC@ligsg2.epfl.ch> 
Date: Tue, 22 Jan 2002 23:10:23 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Ciger <jan.ciger@epfl.ch> said:

[...]

> So, the solution is - teach your users to unmount disks before leaving, or 
> mount them in synchronous mode - but I am not sure, whether VFAT supports 
> that and it is a performance hog too. 

Better use mtools. No mounting required, which does screw DOSish minds.
-- 
Horst von Brand			     http://counter.li.org # 22616
