Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262494AbSI2PSL>; Sun, 29 Sep 2002 11:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262495AbSI2PSL>; Sun, 29 Sep 2002 11:18:11 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:22514 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262494AbSI2PSL>; Sun, 29 Sep 2002 11:18:11 -0400
Subject: Re: [PATCH] linux-2.5.39 - i8xx series chipsets patches (patch3)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020929171305.A7527@medelec.uia.ac.be>
References: <20020929161148.A7376@medelec.uia.ac.be>
	<1033310558.13001.0.camel@irongate.swansea.linux.org.uk> 
	<20020929171305.A7527@medelec.uia.ac.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Sep 2002 16:29:18 +0100
Message-Id: <1033313358.13074.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-09-29 at 16:13, Wim Van Sebroeck wrote:
> > This code is clearly incorrect. Please work off the current 2.4 driver
> > code because all the 2.5 watchdog code is obsolete and has security
> > holes. Worse still - you just added another one.
> 
> Included the patch with the fix for the security hole. For the rest the code is based on the 2.4 driver 
> allready (I only missed your last patch :-( ).

Looks much better. Linus this agrees with my 2.4 tree, and it is (one of
a load) of security fixes that need pushing forwards.

