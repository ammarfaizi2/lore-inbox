Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278795AbRKSNlf>; Mon, 19 Nov 2001 08:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKSNl0>; Mon, 19 Nov 2001 08:41:26 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51605 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S278795AbRKSNlJ>; Mon, 19 Nov 2001 08:41:09 -0500
Date: Mon, 19 Nov 2001 14:41:02 +0100
From: bert hubert <ahu@ds9a.nl>
To: Olivier Sessink <lists@olivier.pk.wau.nl>, linux-kernel@vger.kernel.org
Subject: Re: PCMCIA kernel freezes (yenta_socket) - more info
Message-ID: <20011119144102.B4467@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Olivier Sessink <lists@olivier.pk.wau.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011119132905.6c0591f8.lists@olivier.pk.wau.nl> <20011119143026.A4467@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011119143026.A4467@outpost.ds9a.nl>; from ahu@ds9a.nl on Mon, Nov 19, 2001 at 02:30:26PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2001 at 02:30:26PM +0100, bert hubert wrote:

> > it is a Debian testing (Woody) system with kernel 2.4.14, the following
> > modules are loaded: cb_enabler, ds, yenta_socket and pcmcia_core
> 
> I can corroborate this, have exactly the same problem with a no-name 'MyNote'
> notebook, yenta_socket too. 

Well, not quite - I have the problem when modprobing yenta_socket.

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
