Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263157AbTCSR7b>; Wed, 19 Mar 2003 12:59:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263113AbTCSR7b>; Wed, 19 Mar 2003 12:59:31 -0500
Received: from chaos.analogic.com ([204.178.40.224]:32647 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263164AbTCSR7W>; Wed, 19 Mar 2003 12:59:22 -0500
Date: Wed, 19 Mar 2003 13:12:49 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
cc: John Jasen <jjasen@realityfailure.org>,
       "Richard B. Johnson" <johnson@quark.analogic.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Everything gone!
In-Reply-To: <200303191155.06980.pollard@admin.navo.hpc.mil>
Message-ID: <Pine.LNX.4.53.0303191310570.32397@chaos>
References: <Pine.LNX.4.44.0303191232130.30655-100000@bushido>
 <200303191155.06980.pollard@admin.navo.hpc.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Mar 2003, Jesse Pollard wrote:

> On Wednesday 19 March 2003 11:33 am, John Jasen wrote:
> > On Wed, 19 Mar 2003, Richard B. Johnson wrote:
> > > Really? How did you do this?
> > > Clone my machine-name and domain, I mean? Without -bs in the
> > > header? I need to know. This could be exploited and needs
> > > to be fixed.
> >
> > Perhaps:
> >
> > telnet target.system 25
> > enter SMTP commands
> > quit
>
> Normaly that would record the IP of the host doing the telnet.
> (the first "Recieved: from" line in the log list where the original says
> "Received: from localhost"....)

Yes. I just looked at maillog on that machine and all I had was
the 'evidence' of me screwing with it to see. Apparently it wasn't
used for forwarding mail as I thought.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

