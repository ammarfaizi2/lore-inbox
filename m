Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272529AbRIFTlH>; Thu, 6 Sep 2001 15:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272533AbRIFTk7>; Thu, 6 Sep 2001 15:40:59 -0400
Received: from spike.porcupine.org ([168.100.189.2]:46090 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272529AbRIFTkq>; Thu, 6 Sep 2001 15:40:46 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <E15f4ul-0000J5-00@the-village.bc.nu> "from Alan Cox at Sep 6, 2001
 08:34:15 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Thu, 6 Sep 2001 15:41:06 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, Andrey Savochkin <saw@saw.sw.com.sg>,
        Matthias Andree <matthias.andree@gmx.de>, Andi Kleen <ak@suse.de>,
        linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906194106.E66BCBC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox:
> Strict RFC compliance isn't a real world goal. I doubt any mailer implements 
> SEND, SOML or SAML for example. I definitely agree that the #Number and
> [a.b.c.d] forms are important though, and that you need to be able to
> answer the question. However you need to answer it "is this my address
> from the viewpoint of the peer on this connection". I don't see why 
> user configured data isnt a solution. For the 99.9% of normal cases 
> SIOCGIFCONF is going to give the right data. People doing clever things
> will have to set up config files. simple easy - hard possible.

Cool. I will not waste further time on this until someone takes
SIOCGIFCONF away.

	Wietse
