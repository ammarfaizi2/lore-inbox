Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266627AbTBGQ6P>; Fri, 7 Feb 2003 11:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266643AbTBGQ6N>; Fri, 7 Feb 2003 11:58:13 -0500
Received: from node181b.a2000.nl ([62.108.24.27]:9868 "EHLO ddx.a2000.nu")
	by vger.kernel.org with ESMTP id <S266627AbTBGQ6I>;
	Fri, 7 Feb 2003 11:58:08 -0500
Date: Fri, 7 Feb 2003 18:08:07 +0100 (CET)
From: Stephan van Hienen <raid@a2000.nu>
To: Wim Vinckier <wim-raid@tisnix.be>
cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fsck out of memory
In-Reply-To: <Pine.LNX.4.33.0302071719520.13536-100000@nooks.wimpunk.com>
Message-ID: <Pine.LNX.4.53.0302071807270.1306@ddx.a2000.nu>
References: <Pine.LNX.4.33.0302071719520.13536-100000@nooks.wimpunk.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Wim Vinckier wrote:

> I would really use fsck.ext3...  I guess it will give a lot less errors...

fsck.ext3 = fsck.ext2

]# fsck.ext3 /dev/md0
e2fsck 1.32 (09-Nov-2002)

