Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTFILgu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 07:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263493AbTFILgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 07:36:50 -0400
Received: from rth.ninka.net ([216.101.162.244]:10115 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263452AbTFILgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 07:36:49 -0400
Subject: Re: [PATCH] sch_ingress.c includes <asm/smp.h>
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200306091037.h59Abpox012149@callisto.of.borg>
References: <200306091037.h59Abpox012149@callisto.of.borg>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055159413.9884.4.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Jun 2003 04:50:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 03:37, Geert Uytterhoeven wrote:
> sch_ingress.c includes <asm/smp.h>, causing build failures on UMP-only
> architectures

Geert you should know better than anyone else that
you should send NET fixes to the NET maintainers.

So why aren't you doing that?

-- 
David S. Miller <davem@redhat.com>
