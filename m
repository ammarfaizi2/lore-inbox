Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271034AbSISKg6>; Thu, 19 Sep 2002 06:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271093AbSISKg5>; Thu, 19 Sep 2002 06:36:57 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:28403
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S271034AbSISKg4>; Thu, 19 Sep 2002 06:36:56 -0400
Subject: Re: 2.4.20-pre7-ac2 compile and IrDA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: alexh@ihatent.com, linux-kernel@vger.kernel.org
In-Reply-To: <20020918.183354.50766403.davem@redhat.com>
References: <3D891BD1.8F774946@digeo.com>
	<m3bs6uyerj.fsf_-_@lapper.ihatent.com>
	<1032398756.24835.29.camel@irongate.swansea.linux.org.uk> 
	<20020918.183354.50766403.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 Sep 2002 11:45:15 +0100
Message-Id: <1032432315.26712.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-19 at 02:33, David S. Miller wrote:
> /home/davem/src/BK/marcelo-2.4/include/asm-i386
> ? egrep TIOCM_MODEM_BITS *.h
> ? cd ../../drivers/net/irda
> ? egrep TIOCM_MODEM_BITS *.c
> irtty.c:        int arg = TIOCM_MODEM_BITS;

He said pre7-ac2. I know pre7 is broken, I broke it  8(

