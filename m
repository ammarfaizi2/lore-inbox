Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbTE0Qrv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 12:47:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbTE0Qrv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 12:47:51 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61318 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S263945AbTE0Qru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 12:47:50 -0400
Date: Tue, 27 May 2003 13:59:03 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: manish <manish@storadinc.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20: Proccess stuck in __lock_page ...
In-Reply-To: <3ED38449.2090701@storadinc.com>
Message-ID: <Pine.LNX.4.55L.0305271349500.30637@freak.distro.conectiva>
References: <3ED2DE86.2070406@storadinc.com> <Pine.LNX.4.55L.0305270103220.32094@freak.distro.conectiva>
 <3ED2E8A2.7020609@storadinc.com> <Pine.LNX.4.55L.0305270159020.546@freak.distro.conectiva>
 <3ED38449.2090701@storadinc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, manish wrote:

> >Ok, and does it happen with the stock kernel?
> Yes, with the stock kernel too but after long hrs of runtime ..

Could you try Alt+SysRq+T and send us the output on the locked STOCK
kernel please?
