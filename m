Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312219AbSDEHzA>; Fri, 5 Apr 2002 02:55:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312256AbSDEHyu>; Fri, 5 Apr 2002 02:54:50 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:32716 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S312219AbSDEHyp>; Fri, 5 Apr 2002 02:54:45 -0500
Date: Fri, 5 Apr 2002 09:54:44 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] How to use interruptible_sleep_on() without races ?
Message-ID: <20020405095444.A12558@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020404185232.B27209@bougret.hpl.hp.com> <E16tKGi-0007Sy-00@the-village.bc.nu> <20020404190848.C27209@bougret.hpl.hp.com> <a8jaco$avc$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 04:51:06AM +0000, Linus Torvalds wrote:

> I wouldn't mind a spring cleaning, but the fact is that right now in
> 2.5.x I'd rather have driver writers wake up to the fact that we had a
> spring cleaning in the block layer several months ago, rather than
> introduce a new one ;)

http://www.ibiblio.org/Dave/Dr-Fun/df200204/df20020402.jpg

Couldn't resist :-)

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
