Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbTFVWho (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 18:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbTFVWhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 18:37:43 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:45094 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263587AbTFVWhj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 18:37:39 -0400
Date: Sun, 22 Jun 2003 15:52:12 -0700
From: Andrew Morton <akpm@digeo.com>
To: john@beyondhelp.co.nz
Cc: linux-kernel@vger.kernel.org
Subject: Re: kswapd 2.4.2? ext3
Message-Id: <20030622155212.7a91c5a5.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.53.0306231009150.14730@hades.internal.beyondhelp.co.nz>
References: <Pine.LNX.4.53.0306221150320.6021@hades.internal.beyondhelp.co.nz>
	<20030621200617.648c5ec2.akpm@digeo.com>
	<Pine.LNX.4.53.0306231009150.14730@hades.internal.beyondhelp.co.nz>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Jun 2003 22:51:44.0316 (UTC) FILETIME=[DA6A37C0:01C33910]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Duthie <john@beyondhelp.co.nz> wrote:
>
> yes there is one......
> 
>  would it have somthign to do with a 50 Gb partition ?? (ext3)

More likely a random memory scribble or faulty memory.   Suggest
you run memtest86 for 24 hours on that machines.

