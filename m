Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319344AbSIEXSr>; Thu, 5 Sep 2002 19:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319343AbSIEXSr>; Thu, 5 Sep 2002 19:18:47 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:54000
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319344AbSIEXSq>; Thu, 5 Sep 2002 19:18:46 -0400
Subject: Re: Linux 2.4.20-pre5-ac3 (p4-clockmod.c don't compil)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020905203749.GB3847@ulima.unil.ch>
References: <200209051544.g85Fi6i09215@devserv.devel.redhat.com> 
	<20020905203749.GB3847@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 06 Sep 2002 00:24:01 +0100
Message-Id: <1031268241.7834.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-09-05 at 21:37, Gregoire Favre wrote:
> p4-clockmod.c: In function `cpufreq_p4_validatedc':
> p4-clockmod.c:84: `i' undeclared (first use in this function)
> p4-clockmod.c:84: (Each undeclared identifier is reported only once
> p4-clockmod.c:84: for each function it appears in.)


Fixed

