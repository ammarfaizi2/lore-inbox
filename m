Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281023AbRKGWM5>; Wed, 7 Nov 2001 17:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281021AbRKGWMs>; Wed, 7 Nov 2001 17:12:48 -0500
Received: from pc1-camb5-0-cust171.cam.cable.ntl.com ([62.253.134.171]:56550
	"EHLO fenrus.demon.nl") by vger.kernel.org with ESMTP
	id <S281022AbRKGWM1>; Wed, 7 Nov 2001 17:12:27 -0500
From: arjan@fenrus.demon.nl
To: adilger@turbolabs.com (Andreas Dilger)
Subject: Re: ext3 vs resiserfs vs xfs
cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011107144231.M5922@lynx.no>
X-Newsgroups: fenrus.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.3-6.0.1 (i586))
Message-Id: <E161aud-0000es-00@fenrus.demon.nl>
Date: Wed, 07 Nov 2001 22:11:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011107144231.M5922@lynx.no> you wrote:

> Also, given the large number of similar bug reports, maybe RedHat has a bug in
> their mkinitrd script which doesn't try to mount the root fs with ext3?  I
> don't know enough about their mkinitrd tools to say - Alan, Stephen?

I think most people who report this are using lilo and didn't add the initrd
to the lilo.conf when they upgraded the kernel... So far I've not had a
single report about mkinitrd doing it wrong...
