Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267834AbTAHPkg>; Wed, 8 Jan 2003 10:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267835AbTAHPkg>; Wed, 8 Jan 2003 10:40:36 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:34758 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267834AbTAHPke> convert rfc822-to-8bit; Wed, 8 Jan 2003 10:40:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: markh@compro.net, linux-kernel@vger.kernel.org
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Date: Wed, 8 Jan 2003 09:46:28 -0600
User-Agent: KMail/1.4.1
References: <Pine.LNX.4.10.10301022110580.421-100000@master.linux-ide.org> <200301080933.42461.pollard@admin.navo.hpc.mil> <3E1C47F3.C59B1FFC@compro.net>
In-Reply-To: <3E1C47F3.C59B1FFC@compro.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301080946.28103.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 January 2003 09:46 am, Mark Hounschell wrote:
> Jesse Pollard wrote:
> > On Wednesday 08 January 2003 06:28 am, Mark Hounschell wrote:
> > > Helge Hafting wrote:
> > > > Valdis.Kletnieks@vt.edu wrote:
> > > > > On Tue, 07 Jan 2003 10:08:00 +0100, Helge Hafting
> >
> > <helgehaf@aitel.hist.no>  said:
> > > > > > loss.  Giving away driver code (or at least programming specs)
> > > > > > wouldn't be a loss to nvidia though - because users would still
> > > > > > need to buy those cards.
> > > > >
> > > > > It would be a major loss to nvidia *AND* its customers if it were
> > > > > bankrupted in a lawsuit because it open-sourced code or specs that
> > > > > contained intellectual property that belonged to somebody else.
> > > >
> > > > Perhaps their driver contains some IP.  But I seriously doubt the
> > > > programming specs for their chips contains such secrets.  It is
> > > > not as if we need the entire chip layout - it is basically
> > > > things like:
> > > >
> > > > "To achieve effect X, write command code 0x3477 into register 5
> > > > and the new coordinates into registers 75-78.  Then wait 2.03ms
> > > > before attempting to access the chip again..."
> > > >
> > > > Something is very wrong if they _can't_ release that sort of
> > > > information.
> > > > Several other manufacturers have no problem with this.
> > >
> > > Aren't nvidias' chipsets really owned by SGI. It think there is some
> > > deal nvidia has with SGI that prohibits nvidia from opening up their
> > > driver and chip set info. It's looking like SGI might be gone soon.
> > > Maybe if they disappear, nvidia can do what they want???
> >
> > Think they sold it to Microsoft....
>
> I think what they sold to MS was some part of "OPENGL" software not
> anything hardware
> related.

That part I'm sure of. But part of what was sold is the interface to the 
"OPENGL" software, and that is part of what is implemented by the
nvidia chips. So, by a tenuous extension, the chips interface may be
owned by M$.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
