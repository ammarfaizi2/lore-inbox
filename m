Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278509AbRKDEY7>; Sat, 3 Nov 2001 23:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278511AbRKDEYt>; Sat, 3 Nov 2001 23:24:49 -0500
Received: from quechua.inka.de ([212.227.14.2]:26220 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S278509AbRKDEYj>;
	Sat, 3 Nov 2001 23:24:39 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: CVS / Bug Tracking System
In-Reply-To: <flk.1004824861.fsf@jens.unfaehig.de>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.11-xfs (i686))
Message-Id: <E160Epp-0008Sa-00@calista.inka.de>
Date: Sun, 04 Nov 2001 05:24:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <flk.1004824861.fsf@jens.unfaehig.de> you wrote:
> What are the reasons that Linux isn't kept in an CVS repository?

Some architectures and branches are kept in Source control. Like sparc, xfs.
Also the complete kernel is available in bitkeeper. Linux does not see a
reason to have his version in the CVS. And since he is the only commiter it
is quite valid for him to choose the tool he wants to use.

> mean, it would still give Linus full control over his branch of the
> kernel, and it would make merging of Alan's branches into the main
> branch easier.

It is is not your problem to merge them. Alan and Linus are doing that. And
they are fine without CVS. 

BTW: this discussion is very old, you should only start it, if you have new
facts :)

Greetings
Bernd
