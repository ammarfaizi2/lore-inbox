Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316588AbSGLPfm>; Fri, 12 Jul 2002 11:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316591AbSGLPfl>; Fri, 12 Jul 2002 11:35:41 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40709 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316588AbSGLPfk>; Fri, 12 Jul 2002 11:35:40 -0400
Subject: Re: ext3 corruption
To: alec@shadowstar.net (Alec Smith)
Date: Fri, 12 Jul 2002 17:02:03 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, ext3-users@redhat.com
In-Reply-To: <Pine.LNX.4.44.0207121127001.7507-100000@bugs.home.shadowstar.net> from "Alec Smith" at Jul 12, 2002 11:32:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E17T2rr-0003Hr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Over the last month or so, I've noticed the following error showing up
> repeatedly in my system logs under kernel 2.4.18-ac3 and more recently
> under 2.4.19-rc1:

Force an fsck on the file system firstly
