Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319175AbSHNA01>; Tue, 13 Aug 2002 20:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319180AbSHNA01>; Tue, 13 Aug 2002 20:26:27 -0400
Received: from c-180-196-7.ka.dial.de.ignite.net ([62.180.196.7]:46220 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S319175AbSHNA0Z>; Tue, 13 Aug 2002 20:26:25 -0400
Date: Wed, 14 Aug 2002 02:29:58 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Imran Badr <imran.badr@cavium.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Cache coherency and snooping
Message-ID: <20020814022958.B11645@linux-mips.org>
References: <20020814020825.A11382@linux-mips.org> <0a9c01c24328$5205f470$9e10a8c0@IMRANPC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0a9c01c24328$5205f470$9e10a8c0@IMRANPC>; from imran.badr@cavium.com on Tue, Aug 13, 2002 at 05:19:56PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 05:19:56PM -0700, Imran Badr wrote:

> What if I allocate memory at boot-time using alloc_bootmem*(..)?

That wouldn't change the picture either.

  Ralf
