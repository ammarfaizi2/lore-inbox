Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316942AbSE1VWF>; Tue, 28 May 2002 17:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316946AbSE1VWE>; Tue, 28 May 2002 17:22:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:34542 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316942AbSE1VWD>; Tue, 28 May 2002 17:22:03 -0400
Subject: Re: Kernel (2.4.19-pre8) hang
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Nosi <fredi@e-salute.it>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022616234.2427.34.camel@linux>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 23:24:58 +0100
Message-Id: <1022624698.4124.137.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-05-28 at 21:03, Frederik Nosi wrote:
> <bios>
> Failure Predicted on Primary Master: QUANTUM FIREBALLlct10 15
> Immediatly back-up your data and replace your hard disk drive.
> A failure may be imminent
> </bios>

Your drive told the BIOS it was about to die (via SMART). Its probably
telling the truth. Alas poor disk 

