Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262021AbVHFDTH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262021AbVHFDTH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 23:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVHFDTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 23:19:06 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:4845 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262021AbVHFDTF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 23:19:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=IedcZ1WclxuF0FoXSOEfsWI/r8TFg59XlW/ogpity/QyN5No8Tkys5OA2QoSJC6lLeRB1bS940zoazcZdyraaBkFxggvgMcqzFp3F4HEDNtxr4ygd3n6VuWLte19WsiN3pJk6cTTzzkY20W0/vMP7bA/OtYJhtJQTn4c+ZyqUO4=
Message-ID: <1e62d13705080520194ac11b1f@mail.gmail.com>
Date: Sat, 6 Aug 2005 08:19:05 +0500
From: Fawad Lateef <fawadlateef@gmail.com>
To: "D. ShadowWolf" <dhazelton@enter.net>
Subject: Re: About Linux Device Drivers
Cc: linux-kernel@vger.kernel.org, alex@electrica.cujae.edu.cu
In-Reply-To: <200508052243.44732.dhazelton@enter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42F3C9AE.3040406@electrica.cujae.edu.cu>
	 <1123295169.4984.7.camel@localhost.localdomain>
	 <200508052243.44732.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/05, D. ShadowWolf <dhazelton@enter.net> wrote:
> > On Fri, 2005-08-05 at 22:18 +0200, Alejandro Cabrera wrote:
> > > Hi
> > > I'm new in the list and I'm interested in lkm, I have the Linux Device
> > > Drivers 2ed. And I use the 2.6.8-2 kernel, and the modules that I create
> > > I don't test in my workstation. Exist any way to run the examples
> > > exposed in this book over my kernel or I need the LDD 3ed ????
> > > thx for your patient
> > > Alejandro
> >
> 
> It appears he's interested in writing modules for the Linux Kernel and has
> been using the book 'Linux Device Drivers, Second Edition' as a reference,
> but none of the examples in the book are compiling for him. As he's stated,
> he's running kernel 2.6.8-2.
> 
> He wants to know if there is any way to make the examples in that book work or
> if he has to go pick up the new version of that book.  I've not seen the
> books examples myself, and I'm just trying to get up to speed on the kernel
> internals myself so I can't answer his question.
> 
> Hope the interpretation of his somewhat broken english helps :)
> 

If ShadowWolf interpretation of Alejandro's question is right and
Alejandro trying to run the LDD2 books examples on 2.6.8-2 then they
won't work on 2.6.x kernel or not even compile
successfully............ That LDD2 book is for 2.2 and 2.4 kernel
series and LDD3 is for 2.6 series, so go for LDD3 for your 2.6.x
kernel ..........

-- 
Fawad Lateef
