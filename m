Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSFDM7Y>; Tue, 4 Jun 2002 08:59:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSFDM7X>; Tue, 4 Jun 2002 08:59:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19191 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316611AbSFDM7W>; Tue, 4 Jun 2002 08:59:22 -0400
Subject: Re: [patch] 2.5.20 i2c-elektor fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cranford <ac9410@bellsouth.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "linux-i2c@tk.uni-linz.ac.at" <linux-i2c@tk.uni-linz.ac.at>
In-Reply-To: <3CFC4B11.21A7CE1A@bellsouth.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 15:04:35 +0100
Message-Id: <1023199475.23874.138.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 06:07, Albert Cranford wrote:
> Hello Linus,
> The attached patch fixes i2c-elektor.c exit function.
> Albert
> -- 

Surely you just need to include <linux/init.h> ?

