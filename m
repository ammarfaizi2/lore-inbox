Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272772AbTHENML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 09:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272773AbTHENML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 09:12:11 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19073 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S272772AbTHENMJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 09:12:09 -0400
Date: Tue, 5 Aug 2003 09:13:56 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Rafael Costa dos Santos <rafael@thinkfreak.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: linux syscall list
In-Reply-To: <200308050933.16351.rafael@thinkfreak.com.br>
Message-ID: <Pine.LNX.4.53.0308050912370.5994@chaos>
References: <200308050933.16351.rafael@thinkfreak.com.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003, Rafael Costa dos Santos wrote:

> Hi all,
>
> Where can I find the last linux syscall list ?
>
> --
> Rafael Costa dos Santos

../linux-$vers/include/asm/unistd.h

contains the syscall numbers.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

