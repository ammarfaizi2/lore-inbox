Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTI2PLF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTI2PLF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:11:05 -0400
Received: from cc78409-a.hnglo1.ov.home.nl ([212.120.97.185]:27600 "EHLO
	dexter.hensema.net") by vger.kernel.org with ESMTP id S263524AbTI2PLD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:11:03 -0400
From: Erik Hensema <erik@hensema.net>
Subject: Re: Can't X be elemenated?
Date: Mon, 29 Sep 2003 15:10:59 +0000 (UTC)
Message-ID: <slrnbngis3.37a.erik@bender.home.hensema.net>
References: <LAW11-F18b4SaFMwr9y00007564@hotmail.com>
Reply-To: erik@hensema.net
User-Agent: slrn/0.9.7.4 (Linux)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kartikey bhatt (kartik_me@hotmail.com) wrote:
> I read your reply to a person worried about the future of linux. It was a
> satisfactory reply; I hope to get a satisfactory reply for this one also.
> 
> Can't X be elemenated?
> 
> I mean to say kernel level support for graphics device drivers and special
> routines for accessing it directly; rest will be done by user space widget
> libraries (or say a kernel space light widget library which can be 
> customized
> by user space libraries).

Please take a look at directfb, work is underway to port Qt to it, so
potentionally you could run KDE on the framebuffer console.

It's however quite offtopic here.

-- 
Erik Hensema <erik@hensema.net>
