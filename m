Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282616AbRKZW66>; Mon, 26 Nov 2001 17:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282624AbRKZW6s>; Mon, 26 Nov 2001 17:58:48 -0500
Received: from quechua.inka.de ([212.227.14.2]:16954 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S282616AbRKZW6e>;
	Mon, 26 Nov 2001 17:58:34 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: fdisk file size limit exceeded - 2.4.14
In-Reply-To: <Pine.LNX.3.96.1011126145920.27112E-100000@gatekeeper.tmr.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E168Uhq-0003pn-00@calista.inka.de>
Date: Mon, 26 Nov 2001 23:58:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.3.96.1011126145920.27112E-100000@gatekeeper.tmr.com> you wrote:
> I have seen this reported before, and no solution I can remember.

The problem was with using su to change to root. Login on a terminal as root
and it should work.

Greetings
Bernd
