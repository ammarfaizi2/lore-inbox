Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281093AbRKOWUk>; Thu, 15 Nov 2001 17:20:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281125AbRKOWUb>; Thu, 15 Nov 2001 17:20:31 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:52909
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S281093AbRKOWUP>; Thu, 15 Nov 2001 17:20:15 -0500
From: arjan@fenrus.demon.nl
To: michael@wizard.ca (Michael Peddemors)
Subject: Re: Problem with 2.4.14 mounting i2o device as root device Adaptec 3200 RAID controller?
cc: linux-kernel@vger.kernel.org
In-Reply-To: <1005861234.9918.806.camel@mistress>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E164UpQ-0001AU-00@fenrus.demon.nl>
Date: Thu, 15 Nov 2001 22:17:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1005861234.9918.806.camel@mistress> you wrote:
> might be kernel related so tried a freshly rolled 2.4.14 kernel, and it
> fails to mount the root point /dev/i2o/hda1 (kernel panic, cannot mount
> 5001)

Try the RH errata 2.4.9 kernel, it is supposed to have support for this 
device......
