Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263461AbTEIVKB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263462AbTEIVKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 17:10:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:11581 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263461AbTEIVKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 17:10:00 -0400
Date: Fri, 9 May 2003 14:18:43 -0700
From: Andrew Morton <akpm@digeo.com>
To: dipankar@in.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.69-mm3
Message-Id: <20030509141843.38b10f32.akpm@digeo.com>
In-Reply-To: <20030509141012.GD2059@in.ibm.com>
References: <20030508013958.157b27b7.akpm@digeo.com>
	<20030509141012.GD2059@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 May 2003 21:22:34.0533 (UTC) FILETIME=[1B851D50:01C31671]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
> > rcu-stats.patch
> >   RCU statistics reporting
> 
> I am wondering what we should do with this patch.

How about we just keep it floating about in the experimental kernels?
Can't say that I use it for anything, really.

