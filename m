Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSBDEuA>; Sun, 3 Feb 2002 23:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288484AbSBDEtv>; Sun, 3 Feb 2002 23:49:51 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:13699 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S288473AbSBDEtn>;
	Sun, 3 Feb 2002 23:49:43 -0500
Date: Sun, 3 Feb 2002 23:49:42 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
To: Oliver Feiler <kiza@gmx.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: fixup descriptions in pci-pc.c
In-Reply-To: <20020203152913.A533@gmx.net>
Message-ID: <Pine.LNX.4.30.0202032342400.1158-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good idea.  I frankly hate that message as its vague and stupid.  Heh.  I
actually wrote it... but I did it as a patch to an older message and I
didn't want to really change the poetic essence of the function I
modified.

Feel free to patch this yourself.  I am a bit afraid to bug alan and linus
and marcello with such a small change :)

-Calin

On Sun, 3
Feb 2002, Oliver Feiler wrote:

> 	Ok, this is just a cosmetic thing, but I see that in 2.5.3 the printk
> text in pci_fixup_via_northbridge_bug in pci-pc.c was changed
>
> - printk("Trying to stomp on VIA Northbridge bug...\n");
> + printk("Disabling broken memory write queue.\n");
>
> 	Can't we change this to some meaningful output in 2.4.18 as well? It's
> still the old text with pre7.
>
> Bye
>
> Oliver
>
>


