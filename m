Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263241AbREaVoD>; Thu, 31 May 2001 17:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263250AbREaVnx>; Thu, 31 May 2001 17:43:53 -0400
Received: from quechua.inka.de ([212.227.14.2]:59769 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S263241AbREaVni>;
	Thu, 31 May 2001 17:43:38 -0400
From: Bernd Eckenfels <W1012@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
In-Reply-To: <3B15EF16.89B18D@idcomm.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.0.39 (i686))
Message-Id: <E155aEF-0006VC-00@sites.inka.de>
Date: Thu, 31 May 2001 23:43:39 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3B15EF16.89B18D@idcomm.com> you wrote:
> However, if I go to /proc/sys/kernel/sysrq does not exist.

It is a compile time option, so the person who compiled your kernel left it
out.

> vm.freepages = 383 766 1149

tat feature is removed in recent VM Systems.

Greetings
Bernd
