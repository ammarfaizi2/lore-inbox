Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265084AbSJWPst>; Wed, 23 Oct 2002 11:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbSJWPst>; Wed, 23 Oct 2002 11:48:49 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:49599 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265084AbSJWPss>; Wed, 23 Oct 2002 11:48:48 -0400
Subject: Re: feature request - why not make netif_rx() a pointer?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: hps@intermeta.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <ap6egj$ck$1@forge.intermeta.de>
References: <00b201c27a0e$3f82c220$800a140a@SLNW2K>
	<1035326559.16085.18.camel@rth.ninka.net>  <ap6egj$ck$1@forge.intermeta.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 23 Oct 2002 17:11:34 +0100
Message-Id: <1035389494.3968.63.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-23 at 16:16, Henning P. Schmiedehausen wrote:
> You will never understand, that <insert evil vendor here> can simply
> add this modification to the kernel source ("vendor tree"), give this
> source away under GPL license and then ship its binary kernel modules
> with the source tree.

Thats what lawyers are for. 

> Not putting an export into the source or exporting GPL_ONLY symbols
> won't hinder anyone. Because putting the hooks into a GPL source and
> then releasing the result (code + hooks) under GPL is perfectly legal.

Not according to lawyers

