Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283723AbRLISSc>; Sun, 9 Dec 2001 13:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283724AbRLISSW>; Sun, 9 Dec 2001 13:18:22 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:46765 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S283723AbRLISSL>; Sun, 9 Dec 2001 13:18:11 -0500
Date: Sun, 9 Dec 2001 19:18:05 +0100
From: bert hubert <ahu@ds9a.nl>
To: kuznet@ms2.inr.ac.ru
Cc: jamal <hadi@cyberus.ca>, lartc@mailman.ds9a.nl,
        linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
Message-ID: <20011209191805.A18271@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, kuznet@ms2.inr.ac.ru,
	jamal <hadi@cyberus.ca>, lartc@mailman.ds9a.nl,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <Pine.GSO.4.30.0112081841050.4764-100000@shell.cyberus.ca> <200112091814.VAA00499@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200112091814.VAA00499@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sun, Dec 09, 2001 at 09:14:46PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 09:14:46PM +0300, kuznet@ms2.inr.ac.ru wrote:

> > > But to do this, you would need to be able to set skb->priority to a 32bit
> > > number:
> > Cant think of a straight way to do this .... Alexey would know,
> 
> SO_PRIORITY. Or I did not follow you?

Ah yes, thanks, that sets sk->priority which later sets skb->priority.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
