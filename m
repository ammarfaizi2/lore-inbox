Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267857AbTAHMSE>; Wed, 8 Jan 2003 07:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267858AbTAHMSE>; Wed, 8 Jan 2003 07:18:04 -0500
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:64780 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S267857AbTAHMSD>; Wed, 8 Jan 2003 07:18:03 -0500
Message-ID: <3E1C1971.2A2FD368@compro.net>
Date: Wed, 08 Jan 2003 07:28:33 -0500
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20-ert i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
References: <Pine.LNX.4.10.10301022110580.421-100000@master.linux-ide.org> <1041596161.1157.34.camel@fly> <3E158738.4050003@walrond.org> <3E159336.F249C2A1@aitel.hist.no> <3E15A2C8.7060903@walrond.org> <3E195A4B.B160B1D2@aitel.hist.no> <3E196749.8080509@walrond.org>
		            <3E1A98F0.271311CB@aitel.hist.no> <200301071515.h07FFKCR008361@turing-police.cc.vt.edu> <3E1BF82B.E55C84EE@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> 
> Valdis.Kletnieks@vt.edu wrote:
> >
> > On Tue, 07 Jan 2003 10:08:00 +0100, Helge Hafting <helgehaf@aitel.hist.no>  said:
> > > loss.  Giving away driver code (or at least programming specs)
> > > wouldn't be a loss to nvidia though - because users would still
> > > need to buy those cards.
> >
> > It would be a major loss to nvidia *AND* its customers if it were bankrupted in
> > a lawsuit because it open-sourced code or specs that contained intellectual
> > property that belonged to somebody else.
> 
> Perhaps their driver contains some IP.  But I seriously doubt the
> programming specs for their chips contains such secrets.  It is
> not as if we need the entire chip layout - it is basically
> things like:
> 
> "To achieve effect X, write command code 0x3477 into register 5
> and the new coordinates into registers 75-78.  Then wait 2.03ms before
> attempting to access the chip again..."
> 
> Something is very wrong if they _can't_ release that sort of
> information.
> Several other manufacturers have no problem with this.

Aren't nvidias' chipsets really owned by SGI. It think there is some deal nvidia
has with SGI that prohibits nvidia from opening up their driver and chip set
info. It's looking like SGI might be gone soon. Maybe if they disappear, nvidia
can do what they want???


Mark
