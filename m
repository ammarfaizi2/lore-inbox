Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSHDO3M>; Sun, 4 Aug 2002 10:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317809AbSHDO3M>; Sun, 4 Aug 2002 10:29:12 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:60151 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317802AbSHDO3L>; Sun, 4 Aug 2002 10:29:11 -0400
Subject: Re: [PATCH] [RFC] [2.5 i386] GCC 3.1 -march support, PPRO_FENCE
	reduction, prefetch fixes and other CPU-related changes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Barbieri <ldb@ldb.ods.org>
Cc: Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028471237.1294.515.camel@ldb>
References: <1028471237.1294.515.camel@ldb>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 16:50:59 +0100
Message-Id: <1028476259.14196.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 15:27, Luca Barbieri wrote:
> - Makes CONFIG_X86_PPRO_FENCE user-settable and disable if not SMP or
> CPU incompatible with Pentium Pro selected 

PPro fence is required for uniprocessor pentium pro.

Alan

