Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281201AbRLAAd7>; Fri, 30 Nov 2001 19:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281204AbRLAAdt>; Fri, 30 Nov 2001 19:33:49 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:31432 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S281201AbRLAAdn>; Fri, 30 Nov 2001 19:33:43 -0500
Date: Sat, 1 Dec 2001 01:33:41 +0100
From: bert hubert <ahu@ds9a.nl>
To: lartc@mailman.ds9a.nl
Cc: linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, hadi@cyberus.ca
Subject: Finally, CBQ nearly completely documented
Message-ID: <20011201013341.A23830@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, lartc@mailman.ds9a.nl,
	linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru, hadi@cyberus.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After preparing my talk on CBQ/HTB (http://ds9a.nl/cbq-presentation ), I
finally understood how CBQ and filters etc truly work. And I wrote it down.
Check out the Linux Advanced Routing & Shaping HOWTO, it's changed a lot!

Especially this part is very new, please check it for mistakes and
inconsistencies:

  http://ds9a.nl/2.4Routing/HOWTO//cvs/2.4routing/output/2.4routing-9.html

I even got 'split' and 'defmap' figured out, which should be a first. There
is not a single other page online that tells you correctly what these do.

One thing - does *anybody* understand how hash tables work in tc filter, and
what they do? Furthermore, I could use some help with the tc filter police
things.

So if you do understand how these work, please drop me a line.

Thanks!

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
Trilab                                 The Technology People
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
