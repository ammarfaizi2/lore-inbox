Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264399AbTEPJ6i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 05:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTEPJ6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 05:58:37 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:41084 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264399AbTEPJ6h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 05:58:37 -0400
Date: Fri, 16 May 2003 03:13:05 -0700
From: Andrew Morton <akpm@digeo.com>
To: bert hubert <ahu@ds9a.nl>
Cc: ch@murgatroid.com, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-Id: <20030516031305.4e5031d1.akpm@digeo.com>
In-Reply-To: <20030516100432.GA21627@outpost.ds9a.nl>
References: <20030516015407.2768b570.akpm@digeo.com>
	<20030516100432.GA21627@outpost.ds9a.nl>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 May 2003 10:11:24.0048 (UTC) FILETIME=[81550100:01C31B93]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert <ahu@ds9a.nl> wrote:
>
> I'd vote for treating this patch just like the futexes one, making sure that
>  those who know *how* can turn epoll off, but leave it out of make config.

That is precisely what the patch does.
