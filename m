Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287804AbSAIQ0q>; Wed, 9 Jan 2002 11:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287809AbSAIQ0a>; Wed, 9 Jan 2002 11:26:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:65152 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S287804AbSAIQZm>; Wed, 9 Jan 2002 11:25:42 -0500
Date: Wed, 9 Jan 2002 11:27:58 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael Zhu <mylinuxk@yahoo.ca>
cc: linux-kernel@vger.kernel.org
Subject: Re: About Loop Device
In-Reply-To: <20020109161927.23679.qmail@web14907.mail.yahoo.com>
Message-ID: <Pine.LNX.3.95.1020109112617.5394A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Jan 2002, Michael Zhu wrote:
[SNIPPED...]

> connection between my own loop device with the floppy
> disk? I mean how I can connect the loop device with
> the floppy disk to hook the READ/WRITE operations to
> the floppy disk.
> 
> Michael
> 

mount -o loop /dev/fd0 /mnt

Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


