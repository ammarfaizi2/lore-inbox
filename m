Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266898AbSKUQwc>; Thu, 21 Nov 2002 11:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266903AbSKUQwc>; Thu, 21 Nov 2002 11:52:32 -0500
Received: from orion.netbank.com.br ([200.203.199.90]:48136 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id <S266898AbSKUQwb>; Thu, 21 Nov 2002 11:52:31 -0500
Date: Thu, 21 Nov 2002 14:59:29 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drivers/net: fix up header cleanups: remove unneeded sched.h include
Message-ID: <20021121165928.GN31594@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021121130241.GB31594@conectiva.com.br> <3DDD0091.6060400@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DDD0091.6060400@pobox.com>
User-Agent: Mutt/1.4i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Nov 21, 2002 at 10:49:37AM -0500, Jeff Garzik escreveu:
> This patch looks ok, but in the future, please CC me.
> 
> I'm trying to keep 2.4.x and 2.5.x net drivers in sync as much as 
> possible, and your patch doesn't _only_ remove linux/sched.h includes 
> [which would be a 2.5.x-specific patch].

OK, I'll do it and break the patches in the future.

- Arnaldo
