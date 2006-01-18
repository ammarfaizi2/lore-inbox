Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWARXbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWARXbN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:31:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030481AbWARXbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:31:13 -0500
Received: from xenotime.net ([66.160.160.81]:977 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030480AbWARXbM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:31:12 -0500
Date: Wed, 18 Jan 2006 15:31:07 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Alejandro Bonilla Beeche <abonilla@linuxwireless.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: version.h?
In-Reply-To: <43CECEFD.5010200@linuxwireless.org>
Message-ID: <Pine.LNX.4.58.0601181530350.28417@shark.he.net>
References: <43CECEFD.5010200@linuxwireless.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jan 2006, Alejandro Bonilla Beeche wrote:

> Hi,
>
>     Shouldn't there be a version.h on include/linux?
>
> I use the Linus git tree and it's basically broken right now...
>
> debian:~/linux-2.6# joe include/linux/v
> vermagic.h       video_decoder.h  video_encoder.h  vt_buffer.h
> vfs.h            videodev2.h      videotext.h      vt.h
> via.h            videodev.h       vmalloc.h        vt_kern.h

Hi,
It's a generated file... during build.

-- 
~Randy
