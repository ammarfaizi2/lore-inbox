Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282525AbRLFSob>; Thu, 6 Dec 2001 13:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282501AbRLFSoY>; Thu, 6 Dec 2001 13:44:24 -0500
Received: from quechua.inka.de ([212.227.14.2]:31778 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S282525AbRLFSoJ>;
	Thu, 6 Dec 2001 13:44:09 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/sys/vm/(max|min)-readahead effect????
In-Reply-To: <008b01c17dce$d96b08d0$0801a8c0@Stev.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.16-xfs (i686))
Message-Id: <E16C3V2-0007mg-00@calista.inka.de>
Date: Thu, 06 Dec 2001 19:44:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <008b01c17dce$d96b08d0$0801a8c0@Stev.org> you wrote:
>> mkfs /dev/hdb1
>> dd if=/dev/zero of=some-file bs=x count=x
>> What can fragment this file????

> say you wanna write a 500MB file
...
> fit because there is another file on the disk

it is not, he just reformated the disk

