Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262250AbSKDNxO>; Mon, 4 Nov 2002 08:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSKDNxO>; Mon, 4 Nov 2002 08:53:14 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:18832 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262250AbSKDNxO>; Mon, 4 Nov 2002 08:53:14 -0500
Subject: Re: 2.5.45 / boottime oops (pnp bios I think)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: CaT <cat@zip.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021104134604.GE3088@zip.com.au>
References: <20021104025458.GA3088@zip.com.au>
	<1036415133.1106.10.camel@irongate.swansea.linux.org.uk> 
	<20021104134604.GE3088@zip.com.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Nov 2002 14:21:30 +0000
Message-Id: <1036419690.1106.46.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-04 at 13:46, CaT wrote:
> On Mon, Nov 04, 2002 at 01:05:32PM +0000, Alan Cox wrote:
> > On Mon, 2002-11-04 at 02:54, CaT wrote:
> > > When I unselect PNP BIOS the kernel boots fine. With it I get the
> > > oops below. Please note that it was typed out manually and that that was
> > > all that I could get as I could not scroll up or down in any way.
> > > 
> > > The PC is a Gateway laptop.
> > 
> > Buggy PnP bios please provide dmidecode output for that box
> 
> Is this what you wanted?

Thanks. I've added a rule to my tree to disable the pnp bios on that box

