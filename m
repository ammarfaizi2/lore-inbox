Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRCLAwd>; Sun, 11 Mar 2001 19:52:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129270AbRCLAwO>; Sun, 11 Mar 2001 19:52:14 -0500
Received: from quechua.inka.de ([212.227.14.2]:33628 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129249AbRCLAwK>;
	Sun, 11 Mar 2001 19:52:10 -0500
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Status of posix-ACL's
In-Reply-To: <F1457AD86AB6D311A6F200105AD9FB0219E251@EPCNETIN>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.36 (i686))
Message-Id: <E14cGYa-0007oa-00@sites.inka.de>
Date: Mon, 12 Mar 2001 01:51:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <F1457AD86AB6D311A6F200105AD9FB0219E251@EPCNETIN> you wrote:
> What are the biggest problems? (i know that many userland-tools must be
> changed for this).

AFAIK there is no Support in User Land Programs required. You just have
additional tools for managing the ACLs . The main problem with ACLs are the
storage of the additional info in the file system. This is a hard job if you
want to have it for all/most file systems. Remy had a working Version for
ext2, but it never got very public.. dunno why.

NTs ACLs are somewhat messy cause they require too much scanning.

Greetings
Bernd
