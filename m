Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261839AbSKZXzV>; Tue, 26 Nov 2002 18:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261506AbSKZXzU>; Tue, 26 Nov 2002 18:55:20 -0500
Received: from smtp.comcast.net ([24.153.64.2]:11684 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S261839AbSKZXyx>;
	Tue, 26 Nov 2002 18:54:53 -0500
Date: Tue, 26 Nov 2002 19:01:46 -0500
From: Tom Vier <tmv@comcast.net>
Subject: Re: Linux 2.4.20-rc4
In-reply-to: <Pine.LNX.4.44L.0211261115330.698-100000@freak.distro.conectiva>
To: linux-kernel@vger.kernel.org
Reply-to: Tom Vier <tmv@comcast.net>
Message-id: <20021127000146.GA9004@yzero>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
References: <Pine.LNX.4.44L.0211261115330.698-100000@freak.distro.conectiva>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 26, 2002 at 11:16:24AM -0200, Marcelo Tosatti wrote:
> <ralf@dea.linux-mips.net>:
>   o The BLKGETSIZE ioctl expects an unsigned long argument

according the ioctl_list(2) it's *int, not unsigned long. or is glibc still
using *int for compatibility?

-- 
Tom Vier <tmv@comcast.net>
DSA Key ID 0xE6CB97DA
