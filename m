Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpCcD2iupaPNNRqO5ezR+PtYg0g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sat, 03 Jan 2004 17:40:48 +0000
Message-ID: <011001c415a4$270586f0$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:40:24 +0100
From: "Vojtech Pavlik" <vojtech@suse.cz>
To: <Administrator@osdl.org>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, "Andrew Morton" <akpm@osdl.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/7] psmouse option parsing
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
References: <200401030350.43437.dtor_core@ameritech.net> <200401030400.55755.dtor_core@ameritech.net> <20040103100739.GB499@ucw.cz> <200401031229.25315.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <200401031229.25315.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:40:43.0296 (UTC) FILETIME=[321F7A00:01C415A4]

On Sat, Jan 03, 2004 at 12:29:23PM -0500, Dmitry Torokhov wrote:

> On Saturday 03 January 2004 05:07 am, Vojtech Pavlik wrote:
> > On Sat, Jan 03, 2004 at 04:00:54AM -0500, Dmitry Torokhov wrote:
> > > +			[HW,MOUSE] Controls Logitech smartscroll autoreteat,
> > > +			0 = disabled, 1 = enabled (default).
> >
> > Ha, a typo. :)
> 
> Darn! :)
> 
> Sorry about that. I uploaded hand-corrected patch to 
> 
> http://www.geocities.co/dt_or/input/2_6_0-rc1/ 
> 
> and also sending it here for your reference.
> 
> Dmitry

Patch is OK now. The first (i8042 reset) patch is also OK, I misread it
when I thought I've found problems there.

Andrew, please apply these patches to your tree and/or
schedule them for inclusion into mainline.

Good work, Dmitry!

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
