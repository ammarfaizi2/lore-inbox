Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTH2PTb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 11:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbTH2PTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 11:19:31 -0400
Received: from miranda.zianet.com ([216.234.192.169]:35844 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S261292AbTH2PSu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 11:18:50 -0400
Subject: Re: [PATCH] M68k invalid vs. illegal
From: Steven Cole <elenstev@mesatop.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <200308291451.h7TEp7BC005902@callisto.of.borg>
References: <200308291451.h7TEp7BC005902@callisto.of.borg>
Content-Type: text/plain
Organization: 
Message-Id: <1062170273.20076.25.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 29 Aug 2003 09:17:54 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-08-29 at 08:51, Geert Uytterhoeven wrote:
> M68k: Use `invalid' instead of `illegal' (from Steven Cole in 2.5.x)
> 

For the record, the original idea for these changes should be credited
to Richard B. Johnson via this post:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105278255404767&w=2

Alan verified that Richard was right, and all I did was the grunt work.

Steven

