Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262020AbRETAZZ>; Sat, 19 May 2001 20:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262029AbRETAZP>; Sat, 19 May 2001 20:25:15 -0400
Received: from paloma16.e0k.nbg-hannover.de ([62.159.219.16]:57743 "HELO
	paloma16.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S262025AbRETAZI>; Sat, 19 May 2001 20:25:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dieter =?iso-8859-1?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Mike Galbraith <mikeg@wen-online.de>
Subject: Re: [RFC][PATCH] Re: Linux 2.4.4-ac10
Date: Sun, 20 May 2001 02:52:36 +0200
X-Mailer: KMail [version 1.2.1]
Cc: "Linux Kernel List" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010520002510Z262025-1104+2727@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Three back to back make -j 30 runs for three different kernels.
> > Swap cache numbers are taken immediately after last completion.
>
> The performance increase is nice, though.  Do you see similar
> changes in different kinds of workloads ?

I you have a patch against 2.4.4-ac11 I will do some tests with some 
(interactive) 3D apps.

-Dieter

