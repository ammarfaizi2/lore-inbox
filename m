Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291341AbSBGVyR>; Thu, 7 Feb 2002 16:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291343AbSBGVyH>; Thu, 7 Feb 2002 16:54:07 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:39174 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291341AbSBGVxz>; Thu, 7 Feb 2002 16:53:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Linux Kernel Information & Install Kernel Script
Date: 7 Feb 2002 13:53:34 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3ut0u$f60$1@cesium.transmeta.com>
In-Reply-To: <3C6267B7.30A3020D@starband.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C6267B7.30A3020D@starband.net>
By author:    Justin Piszcz <war@starband.net>
In newsgroup: linux.dev.kernel
>
> New site: http://www.installkernel.com/
> It is very light at the moment.
> 
> 1] Latest news about the kernel:
>    http://www.installkernel.com/kernel.html
>    Anything else I should add under 2.4.17?
> 
> 2] Install Kernel (bash script which I am working on)
>     http://www.installkernel.com/ik/index.html
>     ik-0.8.9: Adds -b option, you can build and install the kernel from
> the current directory with -b.
>     Summary of ik:
>     Install Kernel (ik) is a bash script that installs the Linux kernel
> and automatically sets up LILO or GRUB.
>     It also saves your kernel configuration each time you do an install.
> This allows you to restore the newest
>     configuration file when you make a new kernel. This script is
> intended for two groups of people; people
>     new to compiling kernels, and people who are tired of moving files
> around and editing their bootloader
>     configurations every time they install a new kernel.
> 

Sounds like you should make this work as /sbin/installkernel.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
