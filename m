Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318417AbSHEMY1>; Mon, 5 Aug 2002 08:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318418AbSHEMY1>; Mon, 5 Aug 2002 08:24:27 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:53757 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318417AbSHEMYZ>; Mon, 5 Aug 2002 08:24:25 -0400
Subject: Re: Sv: i810 sound broken...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Munck Steenholdt <tmus@get2net.dk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208051145.g75BjRN30389@eday-fe5.tele2.ee>
References: <200208051145.g75BjRN30389@eday-fe5.tele2.ee>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Aug 2002 14:46:36 +0100
Message-Id: <1028555196.18130.36.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 12:45, Thomas Munck Steenholdt wrote:
> > The changes in the recent i810 audio are
> > - Being more pessimistic in our interpretation of codec power up
> > - Turning on EAPD in case the BIOS didn't do so at boot up
> > 
> > Longer term full EAPD control as we do with the cs46xx is on my list,
> > paticularly as i8xx laptops are becoming common . (EAPD is the amplifier
> > power controller)
> 
> That's strange - I get the same scratchy sounds on 2.4.19 as I did on 2.4.18 
> and a couple of the 2.4.19-pre's... Is there anything I should try, to
> make sure things are configged / built correctly..?

What was the last tree that worked correctly on your box ?

Alan
