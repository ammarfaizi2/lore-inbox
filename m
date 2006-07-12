Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750896AbWGLITT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWGLITT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWGLITT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:19:19 -0400
Received: from smtp.nildram.co.uk ([195.112.4.54]:23825 "EHLO
	smtp.nildram.co.uk") by vger.kernel.org with ESMTP id S1750896AbWGLITS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:19:18 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Thomas Tuttle <thinkinginbinary@gmail.com>
Subject: Re: Will there be Intel Wireless 3945ABG support?
Date: Wed, 12 Jul 2006 09:19:44 +0100
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Thorsten Kranzkowski <dl8bcu@dl8bcu.de>,
       Alon Bar-Lev <alon.barlev@gmail.com>,
       "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711201615.GB11871@Marvin.DL8BCU.ampr.org> <20060712004212.GA26712@phoenix>
In-Reply-To: <20060712004212.GA26712@phoenix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607120919.44561.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 July 2006 01:42, Thomas Tuttle wrote:
> On July 11 at 16:16 EDT, Thorsten Kranzkowski hastily scribbled:
> > On Tue, Jul 11, 2006 at 09:25:45PM +0300, Alon Bar-Lev wrote:
> > > Also there is no good reason why supplying this daemon as closed
> > > source... All they
> > > wish is people don't mess with their frequencies, and sooner or later
> > > someone will...
> >
> > Using interesting frequencies or output power would be fun for
> > radio amateurs (like me). 2.4GHz is one of our playgrounds after all :-)
>
> Hear, hear!
>
> > Just because Joe Average isn't allowed to use such features doesn't
> > mean that there aren't any legitimate users for it.
> >
> > Preventing the accidental use of unauthorized features would be enough,
> > I think (warnings that force you to look up the manual to find out the
> > correct --force option or similar)
> > I expect developers to be sensible enough to only offer 'public legal'
> > values in the default options list.
>
> Frankly, I think Intel is misinterpreting how strict the FCC is being
> (or maybe the FCC is being too strict).  I would interpret their
> mandates as meaning that, as purchased, equipment can't transmit on
> unauthorized frequencies, and that it's not "user-modifiable".  User
> modification doesn't include things like opening the case of a toy
> walkie-talkie up and swapping out a crystal, nor does it include things
> like opening up the firmware or driver for something and messing with
> it.

If you give Matthieu's link[1] a quick read, the OpenBSD developer that 
reverse engineered the regulatory blob seems to indicate that the FCC 
regulations are just an excuse, so Intel can hide their IP inside the blob.

I'm not sure to what extent this is accurate, but it would seem that you would 
leave the driver functionally impaired if you simply removed the regulatory 
checks.

[1] http://kerneltrap.org/node/6650

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
