Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268285AbUJTPMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268285AbUJTPMh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267656AbUJTPIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:08:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:13184 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268059AbUJTPCG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:02:06 -0400
Date: Wed, 20 Oct 2004 11:01:34 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Module compilation
In-Reply-To: <1098283790.3872.115.camel@baythorne.infradead.org>
Message-ID: <Pine.LNX.4.61.0410201100360.12170@chaos.analogic.com>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
 <1098283790.3872.115.camel@baythorne.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, David Woodhouse wrote:

> On Wed, 2004-10-20 at 10:36 -0400, Richard B. Johnson wrote:
>> Could whomever remade the kernel Makefile, please add
>> a variable, initially set to "", like CFLAGS_KERNEL, that
>> is exported and is always included on the compiler command-
>> line?
>
> EXTRA_CFLAGS
>
> -- 
> dwmw2

Okay. I'll use that, even though it's not a "CFLAGS"! Apparently
that's what I'm supposed to us.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
