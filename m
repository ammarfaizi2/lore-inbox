Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129210AbQLAOhG>; Fri, 1 Dec 2000 09:37:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLAOg4>; Fri, 1 Dec 2000 09:36:56 -0500
Received: from proxy.ovh.net ([213.244.20.42]:55560 "HELO proxy.ovh.net")
	by vger.kernel.org with SMTP id <S129210AbQLAOgq>;
	Fri, 1 Dec 2000 09:36:46 -0500
Message-ID: <3A27B04B.1A628ADE@ovh.net>
Date: Fri, 01 Dec 2000 15:06:03 +0100
From: octave klaba <oles@ovh.net>
X-Mailer: Mozilla 4.73 [en] (Win98; I)
X-Accept-Language: fr,en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: watchdog software
In-Reply-To: <E141pts-0000Dn-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Alan Cox wrote:
> 
> > We have a problem on a 2.2.17: sometimes it crashs
> > without any reason (no high load), there is no kernel panic,
> > the screan is black. We setup watchdog software and
> > we realized watchdog can not reboot this box whe it crashs
> > (on the others servers it works fine).
> >
> > my question is:
> > what kind of problem can have this serveur:
> > hardware or software ?
> 
> What sort of watchdog are you using ?

software. no hardware solution.
http://www.ibiblio.org/pub/Linux/system/daemons/watchdog/watchdog-5.1.tar.gz

Octave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
