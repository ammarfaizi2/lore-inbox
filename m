Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263580AbUDGNyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 09:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbUDGNyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 09:54:44 -0400
Received: from chaos.analogic.com ([204.178.40.224]:38529 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263580AbUDGNyn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 09:54:43 -0400
Date: Wed, 7 Apr 2004 09:56:11 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Mohamed Aslan <mkernel@linuxmail.org>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Rewrite Kernel
In-Reply-To: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
Message-ID: <Pine.LNX.4.53.0404070950030.10718@chaos>
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Mohamed Aslan wrote:

> i wanna to rewrite a version of linux kernel from scratch in assembly
> for intel 386+ fo speed and a libc also in assembly for speed
> what do u think guys
> --

I have a version of libc that has a lot of code written in assembly.
All of the Linux interface, all the string stuff, etc. You can have a
copy, if you want. That is a start.

This will be a big project. There's a lot more to the Linux kernel than
just creating some I/O capability. Linux has to emulate Unix so it's
a lot more work than rolling your own 32-bit OS with a file-system.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


