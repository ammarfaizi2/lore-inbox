Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267325AbSLKVtj>; Wed, 11 Dec 2002 16:49:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267327AbSLKVtj>; Wed, 11 Dec 2002 16:49:39 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:25796
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267325AbSLKVti>; Wed, 11 Dec 2002 16:49:38 -0500
Subject: Re: Same with Linux 2.4.20-ac2 <-> Re: Problems compiling 2.4.20 -
	fail just in 'make' - please help
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: system_lists@nullzone.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <5.1.1.6.2.20021211223006.00cded00@192.168.2.131>
References: <Pine.LNX.4.33L2.0212111138530.15702-100000@dragon.pdx.osdl
	.net> <20021211192105.GA1649@localhost.localdomain> 
	<5.1.1.6.2.20021211223006.00cded00@192.168.2.131>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 22:34:54 +0000
Message-Id: <1039646094.18412.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 21:33, system_lists@nullzone.org wrote:
> 
> Same problem with Linux 2.4.20-ac2
> 
> I think its not a kernel code problem. Have any some idea about the real one?
> Any compatibility problem with gcc3.2.2 in variable use?
> 
> BTW: special warning with:
> -> /usr/src/linux-2.4.20/include/linux/kernel.h:10:20: stdarg.h: No such 
> file or directory

You appear to be missing compiler headers from gcc 

