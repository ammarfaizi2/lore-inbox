Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbSKQBJo>; Sat, 16 Nov 2002 20:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267427AbSKQBJo>; Sat, 16 Nov 2002 20:09:44 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:54705 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267426AbSKQBJn>; Sat, 16 Nov 2002 20:09:43 -0500
Subject: Re: Dead & Dying interfaces
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Matthew Wilcox <willy@debian.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021117004059.GC28824@kroah.com>
References: <20021115184725.H20070@parcelfarce.linux.theplanet.co.uk> 
	<20021117004059.GC28824@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 01:43:36 +0000
Message-Id: <1037497416.24843.43.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 00:41, Greg KH wrote:
> On Fri, Nov 15, 2002 at 06:47:25PM +0000, Matthew Wilcox wrote:
> > 
> > pcibios_*
> >  -> Documentation/pci.txt
> 
> I still have patches that remove all of the instances of this.  I think
> it's already in the -ac kernel.  I'll forward port it next week and send
> it to Linus.

Its in the -ac tree. No problems reported except the pcmcia bug which
you sent a patch for

