Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264945AbSLJUnR>; Tue, 10 Dec 2002 15:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbSLJUnR>; Tue, 10 Dec 2002 15:43:17 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:54720 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264945AbSLJUnQ>; Tue, 10 Dec 2002 15:43:16 -0500
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1039549178.7224.7.camel@sonja>
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	<20021210055215.GA9124@suse.de>  <1039504941.30881.10.camel@sonja>
	<1039539080.14302.29.camel@irongate.swansea.linux.org.uk> 
	<1039549178.7224.7.camel@sonja>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 21:24:40 +0000
Message-Id: <1039555481.14302.92.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 19:39, Daniel Egger wrote:
> Do you have pointers to some optimisation manual or whatever?
> gcc currently defines the c3 as 486+mmx+3dnow however I doubt 
> that this model is entirely correct and as such leaves some 
> space for improvements.

VIA are a little odd at times. A vendor that doesn't publish CPU manuals
and push optimisation data at app writers is -odd- by my standards
anyway. I've been discussing a few things with VIA recently and we'll
see what happens over time.

Alan

