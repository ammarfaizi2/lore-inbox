Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266259AbTAFE4Z>; Sun, 5 Jan 2003 23:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbTAFE4Z>; Sun, 5 Jan 2003 23:56:25 -0500
Received: from packet.digeo.com ([12.110.80.53]:35240 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266259AbTAFE4Y>;
	Sun, 5 Jan 2003 23:56:24 -0500
Message-ID: <3E190E75.F63A20CF@digeo.com>
Date: Sun, 05 Jan 2003 21:04:53 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.5.54): devfs shrink - integration candidate
References: <20030105201413.A10685@adam.yggdrasil.com> <20030105203725.A10808@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Jan 2003 05:04:54.0048 (UTC) FILETIME=[26563200:01C2B541]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         The sixth iteration of my devfs code shink is available here:
> 
> ftp://ftp.yggdrasil.com/pub/dist/device_control/devfs/smalldevfs-2.5.54-v6.patch

That diff removes fs/namei.c.
