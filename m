Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbRE0SfS>; Sun, 27 May 2001 14:35:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262860AbRE0SfI>; Sun, 27 May 2001 14:35:08 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30989 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S262859AbRE0Se6>; Sun, 27 May 2001 14:34:58 -0400
Subject: Re: Problems with ac12 kernels and up
To: jcwren@jcwren.com
Date: Sun, 27 May 2001 19:32:09 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <NDBBKBJHGFJMEMHPOPEGOEEGCHAA.jcwren@jcwren.com> from "John Chris Wren" at May 27, 2001 02:24:03 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1545Kk-0002DC-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://jcwren.com/linux/ac18.txt - ac18 dmesg dump
> http://jcwren.com/linux/build.txt - sequence I'm using to build
> 
> The apparent interleaved garbage closer to the bottom is exactly what came
> out on the console.  (Is linking to the dumps perferred over including it in
> the mail, or would folks prefer to have the text included?  Since I'm not a

The link is fine..

> I also rebuilt the ac12 kernel, and tried again.  Same results as the quoted
> text above.

This looks a lot like the superblock changes not only broke reiserfs but also
initd usage.

Al ?

