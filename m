Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265848AbTF3KCh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 06:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265851AbTF3KCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 06:02:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:28668 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265848AbTF3KCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 06:02:34 -0400
Date: Mon, 30 Jun 2003 03:17:04 -0700
From: Andrew Morton <akpm@digeo.com>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org,
       felipe_alfaro@linuxmail.org, zwane@linuxpower.ca, efault@gmx.de
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Message-Id: <20030630031704.651dc862.akpm@digeo.com>
In-Reply-To: <200306301207.27585.m.c.p@wolk-project.de>
References: <200306281516.12975.kernel@kolivas.org>
	<200306301135.37960.m.c.p@wolk-project.de>
	<20030630024749.77be1d6d.akpm@digeo.com>
	<200306301207.27585.m.c.p@wolk-project.de>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jun 2003 10:16:54.0011 (UTC) FILETIME=[BA981CB0:01C33EF0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> wrote:
>
> Now I've tried your suggestion, "make -j2" with .73-mm2 + the mentioned 
>  patches. Three skips during the whole compilation (bzImage modules).

And what happens without the scheduler patches?
