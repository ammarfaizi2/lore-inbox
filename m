Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267222AbTBLRVy>; Wed, 12 Feb 2003 12:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267243AbTBLRVy>; Wed, 12 Feb 2003 12:21:54 -0500
Received: from packet.digeo.com ([12.110.80.53]:55517 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267222AbTBLRVy>;
	Wed, 12 Feb 2003 12:21:54 -0500
Date: Wed, 12 Feb 2003 09:31:42 -0800
From: Andrew Morton <akpm@digeo.com>
To: Core <core@enodev.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NO BOOT] 2.5.60-mm1 wont start to boot for me
Message-Id: <20030212093142.0ef4df53.akpm@digeo.com>
In-Reply-To: <1045068261.13115.13.camel@localhost.localdomain>
References: <1045068261.13115.13.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Feb 2003 17:31:36.0870 (UTC) FILETIME=[982F0C60:01C2D2BC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Core <core@enodev.com> wrote:
>
> I'm just getting my feet wet with 2.5.x, so this might be a newbie
> .config-2.5 uestion.
> 
> The only messages on my console at all indicating any sort of boot is
> grub saying it's loading the kernel. I little disk activity (few blinks)
> and that's it. No ctrl-alt-delete, etc. Nothing in the logs indicating
> 2.5 mounted the root fs, either.
> 

Yes, you'll need to enable virtual terminals, and console on virtual
terminal.   I don't think anyone knows what went wrong here yet.
