Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275752AbRJBBN5>; Mon, 1 Oct 2001 21:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275753AbRJBBNs>; Mon, 1 Oct 2001 21:13:48 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:19127 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S275752AbRJBBNj>; Mon, 1 Oct 2001 21:13:39 -0400
Message-ID: <3BB914DE.7F7E331E@bigfoot.com>
Date: Mon, 01 Oct 2001 18:14:06 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jordan Breeding <ledzep37@home.com>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Increasing dmesg buffer size?
In-Reply-To: <3BB90039.E551000C@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Breeding wrote:
> 
> What kernel parameter do I need to modify in the source to allow a
> larger dmesg buffer?  I have a lot of boot messages and I currently

Note the -s flag.

rgds,
tim.

DMESG(8)                                                 DMESG(8)

NAME
       dmesg - print or control the kernel ring buffer

SYNOPSIS
       dmesg [ -c ] [ -n level ] [ -s bufsize ]


--
