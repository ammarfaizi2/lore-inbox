Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262258AbSKHPwp>; Fri, 8 Nov 2002 10:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266369AbSKHPwp>; Fri, 8 Nov 2002 10:52:45 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:3996 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262258AbSKHPwo>; Fri, 8 Nov 2002 10:52:44 -0500
Subject: Re: [BUG][PATCH] 2.5.46 ide-dma oops on boot
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15819.36010.413947.840428@kim.it.uu.se>
References: <15819.36010.413947.840428@kim.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 16:22:50 +0000
Message-Id: <1036772570.16626.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 10:06, Mikael Pettersson wrote:
> The patch below fixes this issue for me, although this oops
> may just be a consequence of some deeper problem.

Its part of the needed fix. I have a fuller one in the pending queue
that someone sent me, and is waiting for when I get back into the IDE
code

