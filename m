Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290646AbSBFQhj>; Wed, 6 Feb 2002 11:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290652AbSBFQha>; Wed, 6 Feb 2002 11:37:30 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:17067 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S290646AbSBFQhS>; Wed, 6 Feb 2002 11:37:18 -0500
Date: Wed, 6 Feb 2002 17:37:12 +0100
From: bert hubert <ahu@ds9a.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andi Kleen <ak@suse.de>,
        Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        linux-kernel@vger.kernel.org
Subject: Re: kernel: ldt allocation failed
Message-ID: <20020206173712.A5773@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020206150949.A10871@wotan.suse.de> <E16YTEi-0005KG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16YTEi-0005KG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Feb 06, 2002 at 02:34:06PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 02:34:06PM +0000, Alan Cox wrote:

> The more I see from glibc the more I realise that Linus is right - it needs
> replacing 

Felix Leitner, the diet-libc man, loves to point out the difference between
his popen.c and the one in glibc. The dietlibc version is obviously correct
and 37 lines. The glibc version is 337 lines and full of goobledygook.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
Netherlabs BV / Rent-a-Nerd.nl           - Nerd Available -
Linux Advanced Routing & Traffic Control: http://ds9a.nl/lartc
