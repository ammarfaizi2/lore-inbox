Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSJDUD2>; Fri, 4 Oct 2002 16:03:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262318AbSJDUD2>; Fri, 4 Oct 2002 16:03:28 -0400
Received: from vger.timpanogas.org ([216.250.140.154]:3294 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S262314AbSJDUD1>; Fri, 4 Oct 2002 16:03:27 -0400
Date: Fri, 4 Oct 2002 14:01:41 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 3DNOW Question/MMX Support in 2.4.X tree
Message-ID: <20021004140141.A29819@vger.timpanogas.org>
References: <20021004121543.A29145@vger.timpanogas.org> <1033757127.31839.49.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033757127.31839.49.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 04, 2002 at 07:45:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan,

Thanks for the prompt response.  I will test with P4 and see 
how much improvement there is.

:-)

Jeff

On Fri, Oct 04, 2002 at 07:45:27PM +0100, Alan Cox wrote:
> On Fri, 2002-10-04 at 20:15, Jeff V. Merkey wrote:
> > I noticed that the MMX libraries seem tied to CYRIX and AMD builds 
> > in the config scripts.  I am wondering if MMX support for Intel 
> > is not supported in 2.4.X kernels except for these processor types.
> > The code appears to be usable on Intel.
> 
> MMX copies are only a win on some processors, so we only use it in
> kernel there. MMX itself works on all processors
