Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288845AbSBJUA0>; Sun, 10 Feb 2002 15:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288950AbSBJUAQ>; Sun, 10 Feb 2002 15:00:16 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:15066 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S288845AbSBJT76>; Sun, 10 Feb 2002 14:59:58 -0500
Date: Sun, 10 Feb 2002 20:59:57 +0100
From: bert hubert <ahu@ds9a.nl>
To: Laurence <laudney@21cn.com>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Transaction TCP patch for Linux
Message-ID: <20020210205957.A13073@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Laurence <laudney@21cn.com>,
	kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020210164754Z289694-13996+20348@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020210164754Z289694-13996+20348@vger.kernel.org>; from laudney@21cn.com on Sun, Feb 10, 2002 at 04:49:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 10, 2002 at 04:49:55PM +0000, Laurence wrote:
> I'd like to be emailed comments or replies personally.
> 
> Transaction TCP is an extension for TCP. Its performance advantage is
> indisputably better than standard TCP. But only FreeBSD integrates
> TTCP into its kernel. So, I've started T/TCP for Linux at
> http://ttcplinux.sourceforge.net or
> http://sourceforge.net/projects/ttcplinux. I'm writing the kernel
> patch for Linux kernel 2.4.2. Is anyone interested in it or have
> anything to say about T/TCP's pros and cons??

I've seen people state that T/TCP is fundamentally broken:

http://groups.google.com/groups?q=alan+cox+%22t/tcp%22&hl=en&scoring=d&selm=linux.kernel.E14vGeS-0005Lu-00%40the-village.bc.nu&rnum=2

http://www.xent.com/FoRK-archive/feb99/0255.html

So I'm not sure if it is worth implementing.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
