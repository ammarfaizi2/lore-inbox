Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbSLKINd>; Wed, 11 Dec 2002 03:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSLKINd>; Wed, 11 Dec 2002 03:13:33 -0500
Received: from rth.ninka.net ([216.101.162.244]:23274 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id <S267057AbSLKINc>;
	Wed, 11 Dec 2002 03:13:32 -0500
Subject: Re: [PATCH] make net/ipv4/route.c compile without CONFIG_PROC_FS
From: "David S. Miller" <davem@redhat.com>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: Arnd Bergmann <arnd@bergmann-dalldorf.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210212149.GN26067@conectiva.com.br>
References: <200212102208.31562.arnd@bergmann-dalldorf.de> 
	<20021210212149.GN26067@conectiva.com.br>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 00:47:09 -0800
Message-Id: <1039596429.24730.8.camel@rth.ninka.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 13:21, Arnaldo Carvalho de Melo wrote:
> uups, sorry, but this will not be needed after I convert the rest
> of net/ipv4/route.c to seq_file.

So I'll just wait for that :-)


