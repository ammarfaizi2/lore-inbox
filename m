Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261344AbSIZQm0>; Thu, 26 Sep 2002 12:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261345AbSIZQm0>; Thu, 26 Sep 2002 12:42:26 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:10234
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261344AbSIZQmZ>; Thu, 26 Sep 2002 12:42:25 -0400
Subject: Re: AMD 768 erratum 10 (solved: AMD 760MPX DMA lockup)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: 20020912161258.A9056@informatics.muni.cz, linux-kernel@vger.kernel.org,
       Mark Hahn <hahn@physics.mcmaster.ca>, kernel@street-vision.com,
       Petr Konecny <pekon@informatics.muni.cz>,
       "Bruno A. Crespo" <bruno@conectatv.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20020926153410.GA4381@suse.de>
References: <20020925132422.GC14381@fi.muni.cz>
	<1033052890.1269.28.camel@irongate.swansea.linux.org.uk> 
	<20020926153410.GA4381@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 17:51:58 +0100
Message-Id: <1033059118.11848.109.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-26 at 16:34, Dave Jones wrote:
> Converting a *lot* of MP systems to UP due to an errata
> that only occurs with no PS/2 mouse seems a bit extreme.

It would help no end in reducing power bills 8)

I'm just talking about keeping the system running SMP with PIC mode
interrupts.

