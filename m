Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278714AbRKSNay>; Mon, 19 Nov 2001 08:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKSNao>; Mon, 19 Nov 2001 08:30:44 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:49045 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S278714AbRKSNai>; Mon, 19 Nov 2001 08:30:38 -0500
Date: Mon, 19 Nov 2001 14:30:26 +0100
From: bert hubert <ahu@ds9a.nl>
To: Olivier Sessink <lists@olivier.pk.wau.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PCMCIA kernel freezes (yenta_socket) - more info
Message-ID: <20011119143026.A4467@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Olivier Sessink <lists@olivier.pk.wau.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011119132905.6c0591f8.lists@olivier.pk.wau.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119132905.6c0591f8.lists@olivier.pk.wau.nl>; from lists@olivier.pk.wau.nl on Mon, Nov 19, 2001 at 01:29:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 01:29:05PM +0100, Olivier Sessink wrote:
> Hi all,
> 
> when I insert a PCMCIA card (3 cards tested) in my Sony Vaio R600HEK the
> system freezes. When I remove the card it runs again. logs show nothing,
> dmesg shows nothing.. 
> 
> When I boot the system with a PCMCIA card in the slot, it works AND I can
> remove it and add it again without a problem!!??!!
> 
> So the workaround it to boot it with a card always, but that is not really
> convenient..
> 
> it is a Debian testing (Woody) system with kernel 2.4.14, the following
> modules are loaded: cb_enabler, ds, yenta_socket and pcmcia_core

I can corroborate this, have exactly the same problem with a no-name 'MyNote'
notebook, yenta_socket too. 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
