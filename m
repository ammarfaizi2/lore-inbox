Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129563AbQLAUF5>; Fri, 1 Dec 2000 15:05:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129552AbQLAUFr>; Fri, 1 Dec 2000 15:05:47 -0500
Received: from proxy.ovh.net ([213.244.20.42]:22793 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129351AbQLAUFm>;
	Fri, 1 Dec 2000 15:05:42 -0500
Message-ID: <3A27FD6B.9CC7CA65@ovh.net>
Date: Fri, 01 Dec 2000 20:35:07 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: watchdog software
In-Reply-To: <E141rHA-0000In-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > > > my question is:
> > > > what kind of problem can have this serveur:
> > > > hardware or software ?
> > >
> > > What sort of watchdog are you using ?
> >
> > software. no hardware solution.
> > http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/watchdog-5.1.tar.gz
> 
> The software watchdog will fail if the kernel is badly mashed or interrupts
> are disabled. 
yes.

> That means it doesn't help tell me if the problem was hardware
> or software (nor in general do hardware watchdogs). Is this one box running
> different loads to the others or different in any notable way ?
nothing really different. we have 5-6 servers like this one and
this one have been crashed for 2 days only (once per day).
never before !? when the server crashed the load was 1.2. nothing
really bad.
the only difference is: this server has the serial cart. I was
in contact with Ted for the serial problem on Linux, but I have
no news from about the crashs.
I do not know if the serial cart can crash the server that
interrupts are disabled ?

Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
