Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314180AbSDFLv2>; Sat, 6 Apr 2002 06:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314186AbSDFLv1>; Sat, 6 Apr 2002 06:51:27 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:29847 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S314180AbSDFLv1>; Sat, 6 Apr 2002 06:51:27 -0500
Date: Sat, 6 Apr 2002 13:51:25 +0200
From: bert hubert <ahu@ds9a.nl>
To: Kurt Roeckx <Q@ping.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fsck on ext3 after 20 mounts reports i_blocks=n should be m
Message-ID: <20020406135125.B7289@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>, Kurt Roeckx <Q@ping.be>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020405235647.A29670@outpost.ds9a.nl> <20020406021109.A391@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 06, 2002 at 02:11:09AM +0200, Kurt Roeckx wrote:

> > The fsck reports, from what I can recall:
> > 
> > inode X i_blocks=n, should be m. FIXED
> 
> This happens when your fs was full.  Andrew Morton mailed a patch
> to the list a few days ago.

Thank you. It had indeed been full. 

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
