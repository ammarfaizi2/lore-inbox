Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131506AbRCQDJj>; Fri, 16 Mar 2001 22:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRCQDJ3>; Fri, 16 Mar 2001 22:09:29 -0500
Received: from [216.18.82.221] ([216.18.82.221]:26891 "EHLO
	node0.opengeometry.com") by vger.kernel.org with ESMTP
	id <S131506AbRCQDJP>; Fri, 16 Mar 2001 22:09:15 -0500
Date: Fri, 16 Mar 2001 22:03:36 -0500
From: William Park <parkw@better.net>
To: Oliver Paukstadt <oliver@paukstadt.de>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: observations with asus cuv4x-d
Message-ID: <20010316220336.A8763@better.net>
Mail-Followup-To: William Park <parkw@better.net>,
	Oliver Paukstadt <oliver@paukstadt.de>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.05.10103170101410.13178-100000@lara.stud.fh-heilbronn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.05.10103170101410.13178-100000@lara.stud.fh-heilbronn.de>; from pstadt@stud.fh-heilbronn.de on Sat, Mar 17, 2001 at 01:08:19AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2001 at 01:08:19AM +0100, Oliver Paukstadt wrote:
> HY HY
> 
> I changed my motherboard to a asus cuv4x-d with 2 PIII-800.
> 
> With MPS 1.4 enabled (BIOS), i'll get 
> probable hardware bug: clock timer configuration lost - probably a VIA686a
> motherboard (linux/arch/i386/kernel/time.c)
> I use 2.4.2-ac20
> 
> Disabling MPS1.4 causes the Board to work without any problems.

Spec says CUV4x-d is 686B.

:wq --William Park, Open Geometry Consulting, Linux/Python, 8 CPUs.
