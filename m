Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318332AbSHUO6X>; Wed, 21 Aug 2002 10:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318349AbSHUO6X>; Wed, 21 Aug 2002 10:58:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:53742 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318332AbSHUO6W>; Wed, 21 Aug 2002 10:58:22 -0400
Subject: Re: 2.4.20-pre2-ac5 Promise PDC20269
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Egger <degger@fhm.edu>
Cc: "Jason C. Pion" <jpion@valhalla.homelinux.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1029938753.3800.2.camel@sonja.de.interearth.com>
References: <Pine.LNX.4.44.0208201845060.10173-100000@valhalla.homelinux.org> 
	<1029937618.26533.32.camel@irongate.swansea.linux.org.uk> 
	<1029938753.3800.2.camel@sonja.de.interearth.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 16:02:55 +0100
Message-Id: <1029942175.26411.83.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 15:05, Daniel Egger wrote:
> Am Mit, 2002-08-21 um 15.46 schrieb Alan Cox:
> 
> > Ok that looks like one of the cases for 80pin cable detect came unstuck.
> > I've added it to the queue to look into
> 
> I've the same troubles on a Socket-A Board with VIA686 chipset and 
> IBM Deskstar harddrive. Do you need any output I may organise?

Please send me an lspci -v, the drive info and the dmesg. I can at least
add it to the reports to find patters even if nothing else

