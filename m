Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129901AbRACUmQ>; Wed, 3 Jan 2001 15:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129853AbRACUl4>; Wed, 3 Jan 2001 15:41:56 -0500
Received: from hermes.mixx.net ([212.84.196.2]:263 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S129901AbRACUlx>;
	Wed, 3 Jan 2001 15:41:53 -0500
Message-ID: <3A53868E.D3A70E3B@innominate.de>
Date: Wed, 03 Jan 2001 21:07:42 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-prerelease i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Diego Liziero <pmcq@interno.emmenet.it>, linux-kernel@vger.kernel.org
Subject: Re: gcc2.96 + prerelease BUG at inode.c:372
In-Reply-To: <200101031919.f03JJQU13197@interno.emmenet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Liziero wrote:
> ->2: after two day under heavy load I've got the following BUG:
>      (I don't know if it's related to the compiler, that's why I'm reporting
>      this.)
> 
> kernel BUG at inode.c:372!

It's a known bug.  A fix is in process and may already be available at
ftp://ftp.kernel.org/pub/linux/kernel/testing

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
