Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266771AbSKUPnG>; Thu, 21 Nov 2002 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266794AbSKUPnG>; Thu, 21 Nov 2002 10:43:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23558 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266771AbSKUPnF>;
	Thu, 21 Nov 2002 10:43:05 -0500
Message-ID: <3DDD0091.6060400@pobox.com>
Date: Thu, 21 Nov 2002 10:49:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net: fix up header cleanups: remove unneeded
 sched.h include
References: <20021121130241.GB31594@conectiva.com.br>
In-Reply-To: <20021121130241.GB31594@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch looks ok, but in the future, please CC me.

I'm trying to keep 2.4.x and 2.5.x net drivers in sync as much as 
possible, and your patch doesn't _only_ remove linux/sched.h includes 
[which would be a 2.5.x-specific patch].

	Jeff



