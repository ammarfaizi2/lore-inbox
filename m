Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUCST02 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 14:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUCST02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 14:26:28 -0500
Received: from [65.39.167.249] ([65.39.167.249]:6349 "HELO innerfire.net")
	by vger.kernel.org with SMTP id S263167AbUCST0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 14:26:06 -0500
Date: Fri, 19 Mar 2004 14:26:05 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Peter Williams <peterw@aurema.com>,
       =?iso-8859-1?B?IkZy6WTpcmljIEwuIFcuIE1ldW5pZXIi?= 
	<1@pervalidus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
 thing
In-Reply-To: <20040319190355.GA30255@ucw.cz>
Message-ID: <Pine.LNX.4.58.0403191424290.12113@innerfire.net>
References: <40593015.9090507@aurema.com> <Pine.LNX.4.58.0403180346000.1276@pervalidus.dyndns.org>
 <40594984.3010001@aurema.com> <Pine.LNX.4.58.0403191236170.10220@innerfire.net>
 <20040319190355.GA30255@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Vojtech Pavlik wrote:

> Date: Fri, 19 Mar 2004 20:03:55 +0100
> From: Vojtech Pavlik <vojtech@suse.cz>
> To: Gerhard Mack <gmack@innerfire.net>
> Cc: Peter Williams <peterw@aurema.com>,
>      "[iso-8859-1] \"Frédéric L. W. Meunier\"" <1@pervalidus.net>,
>      linux-kernel@vger.kernel.org
> Subject: Re: XFree86 seems to be being wrongly accused of doing the wrong
>     thing
>
> On Fri, Mar 19, 2004 at 12:37:37PM -0500, Gerhard Mack wrote:
> > On Thu, 18 Mar 2004, Peter Williams wrote:
> >
> > > Frédéric L. W. Meunier wrote:
> > > > Wrongly ?
> > >
> > > Yes, wrongly.  XFree86 wasn't even running when the messages appeared so
> > > there's no way that it could be to blame.  Also no keys had been pressed
> > > or released.
> >
> > I have a machine here I see that message on before the init scripts even
> > load.
>
> Quick question: Does it go away if you compile USB support into the
> kernel statically?
>

I have USB compiled in and it's still there.  I should also note that the
keyboard is plugged into the ps/2 port.

The mouse on the other hand is plugged into the USB port.

	Gerhard



--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.
