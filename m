Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265505AbTFVEPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 00:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265511AbTFVEPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 00:15:44 -0400
Received: from dp.samba.org ([66.70.73.150]:8113 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265505AbTFVEPo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 00:15:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16117.12138.153293.938793@nanango.paulus.ozlabs.org>
Date: Sun, 22 Jun 2003 14:24:10 +1000 (EST)
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>, cw@f00f.org,
       torvalds@transmeta.com, geert@linux-m68k.org, alan@lxorguk.ukuu.org.uk,
       perex@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Isapnp warning
In-Reply-To: <20030621191705.3c1dbb16.akpm@digeo.com>
References: <20030621125111.0bb3dc1c.akpm@digeo.com>
	<Pine.LNX.4.44.0306211652130.1980-100000@home.transmeta.com>
	<20030622001101.GB10801@conectiva.com.br>
	<20030622014102.GB29661@dingdong.cryptoapps.com>
	<20030622014345.GD10801@conectiva.com.br>
	<20030621191705.3c1dbb16.akpm@digeo.com>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Compared to 2.95.3, gcc-3.3 takes 1.5x as long to compile, and produces a
> kernel which is 200k larger.

I just tried it on PPC.  Compared to 2.95.4, gcc-3.3 took 36% longer
to compile and produced a kernel which was 120k smaller.

Paul.
