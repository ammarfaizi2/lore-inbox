Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132973AbQKGXl4>; Tue, 7 Nov 2000 18:41:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132612AbQKGXk5>; Tue, 7 Nov 2000 18:40:57 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:16717 "EHLO
	amsmta02-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S132228AbQKGXjs>; Tue, 7 Nov 2000 18:39:48 -0500
Date: Wed, 8 Nov 2000 01:47:37 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "J. Dow" <jdow@earthlink.net>
cc: dank@alumni.caltech.edu, atmproj@yahoo.com, linux-kernel@vger.kernel.org
Subject: Re: malloc(1/0) ??
In-Reply-To: <04c301c0488a$694d6360$0a25a8c0@wizardess.wiz>
Message-ID: <Pine.LNX.4.21.0011080146480.32613-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm not sure that is fully responsive, Dan. Why doesn't the
> strcpy throw a hissyfit and coredump?

Because he's a lucky guy and doesn't cross a page boundary. If the
"ffff" thing is the entire Wind95 source code it will dump :-)

> {^_^}


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
