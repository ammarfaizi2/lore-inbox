Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284469AbRLIVyG>; Sun, 9 Dec 2001 16:54:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284472AbRLIVxz>; Sun, 9 Dec 2001 16:53:55 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:44730 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S284469AbRLIVxw>; Sun, 9 Dec 2001 16:53:52 -0500
Date: Sun, 9 Dec 2001 22:53:50 +0100
From: bert hubert <ahu@ds9a.nl>
To: jamal <hadi@cyberus.ca>
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: CBQ and all other qdiscs now REALLY completely documented
Message-ID: <20011209225350.A22512@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, jamal <hadi@cyberus.ca>,
	kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
	netdev@oss.sgi.com
In-Reply-To: <200112091814.VAA00499@ms2.inr.ac.ru> <Pine.GSO.4.30.0112091642480.6079-100000@shell.cyberus.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.30.0112091642480.6079-100000@shell.cyberus.ca>; from hadi@cyberus.ca on Sun, Dec 09, 2001 at 04:45:01PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2001 at 04:45:01PM -0500, jamal wrote:
> > > Cant think of a straight way to do this .... Alexey would know,
> >
> > SO_PRIORITY. Or I did not follow you?
> 
> So priority limits the size of skb->priority to be from 0..6; this wont
> work with that check in cbq.

No, only IP_TOS does so.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
