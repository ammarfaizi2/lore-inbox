Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314339AbSEMRj5>; Mon, 13 May 2002 13:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314343AbSEMRj4>; Mon, 13 May 2002 13:39:56 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:20121 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S314339AbSEMRjz>; Mon, 13 May 2002 13:39:55 -0400
Date: Mon, 13 May 2002 12:39:52 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Pete Zaitcev <zaitcev@redhat.com>
cc: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Strange s390 code in 2.4.19-pre8
In-Reply-To: <20020513123237.C6208@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.44.0205131239000.19498-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 May 2002, Pete Zaitcev wrote:

> If ISDN people are willing to do that, it would be a great
> relief. I did not raise this question because undoubtedly
> they were using fsm.c first, so it was s390 mistake (accorting
> to the comment in the drivers/s390/net/fsm.c).

If you ask nicely ;-)

Okay, I sent Marcelo a patch to do so.

--Kai

