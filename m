Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261381AbSJUNpA>; Mon, 21 Oct 2002 09:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261394AbSJUNpA>; Mon, 21 Oct 2002 09:45:00 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21004 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261381AbSJUNmj>;
	Mon, 21 Oct 2002 09:42:39 -0400
Date: Mon, 21 Oct 2002 14:48:45 +0100
From: Matthew Wilcox <willy@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Matthew Wilcox <willy@debian.org>, Alexander Viro <viro@math.psu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] work around duff ABIs
Message-ID: <20021021144845.H5285@parcelfarce.linux.theplanet.co.uk>
References: <20021020053147.C5285@parcelfarce.linux.theplanet.co.uk> <1035202419.27318.60.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1035202419.27318.60.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Mon, Oct 21, 2002 at 01:13:39PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 01:13:39PM +0100, Alan Cox wrote:
> On Sun, 2002-10-20 at 05:31, Matthew Wilcox wrote:
> > 
> > *sigh*.  i hate this kind of bullshit.  please, don't anyone ever try
> > to pass 64-bit args through the syscall interface again.
> 
> Please bury this crap in arch/hppa/

and arch/mips?

-- 
Revolutions do not require corporate support.
