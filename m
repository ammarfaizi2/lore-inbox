Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293244AbSCAQUF>; Fri, 1 Mar 2002 11:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293236AbSCAQTz>; Fri, 1 Mar 2002 11:19:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55308 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293005AbSCAQTp>; Fri, 1 Mar 2002 11:19:45 -0500
Date: Fri, 1 Mar 2002 12:10:55 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Paul Gortmaker <p_gortmaker@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bluesmoke/MCE support optional
In-Reply-To: <E16gmBy-0003V5-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0203011210300.2391-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 1 Mar 2002, Alan Cox wrote:

> > > +  ranging from a warning message on the console, to halting the machine.
> > > +  Your processor must be a Pentium or newer to support this - check the 
> > > +  flags in /proc/cpuinfo for mce.  Note that some older Pentium systems
> > > +  have a design flaw which leads to false MCE events - for these and
> > > +  old non-MCE processors (386, 486), say N.  Otherwise say Y.
> 
> Its not necessary to say N. 

> On a pentium box with the newer MCE setup code you must force MCE on.

And if you don't ? 

