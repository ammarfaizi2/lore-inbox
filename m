Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266987AbSKQX04>; Sun, 17 Nov 2002 18:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbSKQX04>; Sun, 17 Nov 2002 18:26:56 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:56242 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266987AbSKQX0z>; Sun, 17 Nov 2002 18:26:55 -0500
Subject: Re: lan based kgdb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021117095632.GN4545@lug-owl.de>
References: <20021116182454.GH19061@waste.org>
	<Pine.LNX.4.44.0211161025500.15838-100000@home.transmeta.com> 
	<20021117095632.GN4545@lug-owl.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 14:50:32 +0000
Message-Id: <1037544804.4334.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 09:56, Jan-Benedict Glaw wrote:
> ...which reminds me to DEC's MOP (Maintainence and Operator's Protocol),
> which is ethernet (but not IP) based remote console and a mixture of
> bootp/tftp. Sure, we won't (yet) go as far as sending the next kernel to
> boot via our new console protocol to kexec(), but wait for the very
> first S-Records to arrive:-p

We have working DECnet and MOP server protocol support. That doesn't
mean its a good idea

