Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135185AbRDZIOk>; Thu, 26 Apr 2001 04:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135186AbRDZIOa>; Thu, 26 Apr 2001 04:14:30 -0400
Received: from NS.iNES.RO ([193.230.220.1]:15814 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S135185AbRDZIOT>;
	Thu, 26 Apr 2001 04:14:19 -0400
Message-ID: <3AE7D964.FB817B6E@interplus.ro>
Date: Thu, 26 Apr 2001 11:16:36 +0300
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-ac11 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: lk <linux-kernel@vger.kernel.org>
Subject: Re: Recent ACPI patch
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDDCA@orsmsx35.jf.intel.com> <20010426100531.A2229@maggie.romantica.wg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	BTW, a quick question, can I use ACPI instead of APM now on my SMP
2xPIII ASUS P3D to do some basic power saving stuff, and even a proper
shutdown ???
	What version is OK ???

		Regards,

		Mircea C.


Jens Taprogge wrote:
> 
> On Wed, Apr 25, 2001 at 10:27:42AM -0700, Andrew Grover wrote:
> > > From: Jeff Garzik [mailto:jgarzik@mandrakesoft.com]
> > > Stephen Torri wrote:
> > > >
> > > > I noticed that the big update patch for ACPI was a part of
> > > 2.4.3-ac11 (Can
> > > > remember). Now its not a part of 2.4.3-ac12. Has it been
> > > removed? I have
> > > > turned on experimental settings when running make xconfig.
> > >
> > > Alan noted the update did not build, so it was removed.
> >
> > Doh!
> >
> > OK, I'm on it. ;-) BTW did ACPI in ac11 build for you?
> I build fine here. IIRC one hunk of the patch was rejected.
> 
> It was the first ACPI kernel for my Asus A7V that did power off the
> machine.
> 
> Jens
