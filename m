Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267225AbSK3I7P>; Sat, 30 Nov 2002 03:59:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267226AbSK3I7P>; Sat, 30 Nov 2002 03:59:15 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:30986 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267225AbSK3I7P>;
	Sat, 30 Nov 2002 03:59:15 -0500
Date: Sat, 30 Nov 2002 00:58:09 -0800
From: Greg KH <greg@kroah.com>
To: venom@sns.it
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/security.h missing in fs/hugetlbfs/inode.c
Message-ID: <20021130085808.GU17065@kroah.com>
References: <Pine.LNX.4.43.0211291238360.986-100000@cibs9.sns.it> <Pine.LNX.4.43.0211291243200.1202-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0211291243200.1202-100000@cibs9.sns.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 29, 2002 at 12:43:55PM +0100, venom@sns.it wrote:
> Oh, I was forgetting,
> 
> this is about kernel 2.5.50

Thanks, I've fixed this in my tree, and will send it on to Linus.

greg k-h
