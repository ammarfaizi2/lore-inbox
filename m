Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263742AbRFHAIG>; Thu, 7 Jun 2001 20:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263733AbRFHAHq>; Thu, 7 Jun 2001 20:07:46 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52484 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S263730AbRFHAHo>; Thu, 7 Jun 2001 20:07:44 -0400
Date: Thu, 7 Jun 2001 19:32:28 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM suggestion...
In-Reply-To: <20010608015933.F10688@arthur.ubicom.tudelft.nl>
Message-ID: <Pine.LNX.4.21.0106071931480.1156-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Jun 2001, Erik Mouw wrote:

> On Thu, Jun 07, 2001 at 04:36:05PM -0300, Marcelo Tosatti wrote:
> > On Thu, 7 Jun 2001, Jeff Garzik wrote:
> > > Statistics like this are cheap to use in runtime and should provide
> > > concrete information rather than guesses and estimations...
> > 
> > I've been using LTT (Linux Trace Toolkit) to do similar stuff. 
> 
> But you can't expect everybody to use LTT. If you just make a couple of
> counters and give an easy way to get the values from userspace (proc,
> sysctl, syslog), you'll get bug reports with real information. IMHO
> data from real world workloads make more sense than "it doesn't work"
> reports.

Agreed.

I'm looking forward to do something similar to what Paul Buder suggested,
when I have time. 

