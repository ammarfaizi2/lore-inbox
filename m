Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314230AbSEFGrT>; Mon, 6 May 2002 02:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314231AbSEFGrS>; Mon, 6 May 2002 02:47:18 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:39907 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S314230AbSEFGrR>; Mon, 6 May 2002 02:47:17 -0400
Date: Mon, 6 May 2002 08:47:16 +0200
From: bert hubert <ahu@ds9a.nl>
To: Linus Torvalds <torvalds@transmeta.com>, akpm@zip.com.au
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.14..
Message-ID: <20020506064716.GA8166@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Linus Torvalds <torvalds@transmeta.com>, akpm@zip.com.au,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 06, 2002 at 03:54:46AM +0000, Linus Torvalds wrote:

> releases these days, but I thought I'd point out 2.5.14, since it has some
> interesting fundamental changes to how dirty state is maintained in the
> VM.

I parsed this 'dirty state' sentence all wrong at first :-) Andrew, Linus -
where does the current VM lie in between rmap-vm and aa-vm?

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
