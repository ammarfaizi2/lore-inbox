Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281550AbRKMI0W>; Tue, 13 Nov 2001 03:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281551AbRKMI0M>; Tue, 13 Nov 2001 03:26:12 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:24988
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S281550AbRKMI0B>; Tue, 13 Nov 2001 03:26:01 -0500
From: arjan@fenrus.demon.nl
To: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>
Subject: Re: Weird boot messages using acpismp=force with 2.4.15-pre4
cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BF08B26.D31563C4@home.com>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E163Yrv-0004Qa-00@fenrus.demon.nl>
Date: Tue, 13 Nov 2001 08:24:31 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BF08B26.D31563C4@home.com> you wrote:
> Around a week ago I decided to test the acpismp=force boot time option
> of the current -ac kernels, it worked great and I got the following
> messages upon boot:

> Nov 12 20:15:14 ledzep kernel: init.c:147: bad pte 3fff3163.

Yes known problem; I'm figuring out how to fix this properly instead of with
the hack that is currently used...
