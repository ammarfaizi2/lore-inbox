Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSG2MkY>; Mon, 29 Jul 2002 08:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317036AbSG2MkY>; Mon, 29 Jul 2002 08:40:24 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:50935 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316933AbSG2MkY>; Mon, 29 Jul 2002 08:40:24 -0400
Subject: Re: Linux 2.4.19-rc3-ac3 and ext3 problems
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Gabor Z. Papp" <gzp@myhost.mynet>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020729123706.GC463@gzp2.gzp.hu>
References: <20020729123706.GC463@gzp2.gzp.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 Jul 2002 14:59:29 +0100
Message-Id: <1027951169.842.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-29 at 13:37, Gabor Z. Papp wrote:
> Extreme usage of a IC35L060AVVA07-0 ATA DISK drive,
> 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(100)
> on a PDC20268: (U)DMA Burst Bit ENABLED Primary MASTER Mode
> Secondary MASTER Mode controller ends up with:

Thanks. If you try the same with the base 2.4.19-rc3 can you duplicate
the problem or not ?

