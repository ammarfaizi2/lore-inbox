Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSEXDrm>; Thu, 23 May 2002 23:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314083AbSEXDrl>; Thu, 23 May 2002 23:47:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22025 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S314078AbSEXDrk>; Thu, 23 May 2002 23:47:40 -0400
Date: Thu, 23 May 2002 20:46:38 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Nathan Scott <nathans@sgi.com>
cc: Jan Kara <jack@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Quota patches
In-Reply-To: <20020524123510.A180298@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.44.0205232043070.954-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Nathan Scott wrote:
>
> Moving to newer interfaces implies use of the new ondisk format
> for the quota files (exclusively)

Sure. But I'd assume that just running quotacheck should initialize that,
so..

		Linus

