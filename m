Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313939AbSDQMme>; Wed, 17 Apr 2002 08:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313968AbSDQMmd>; Wed, 17 Apr 2002 08:42:33 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36230 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S313939AbSDQMmc>; Wed, 17 Apr 2002 08:42:32 -0400
Date: Wed, 17 Apr 2002 14:42:31 +0200
From: bert hubert <ahu@ds9a.nl>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Olaf Fraczyk <olaf@navi.pl>,
        linux-kernel@vger.kernel.org
Subject: Re: please merge 64-bit jiffy patches.
Message-ID: <20020417144231.A17983@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Bill Davidsen <davidsen@tmr.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020417131228.A16445@outpost.ds9a.nl> <Pine.LNX.3.96.1020417082823.31842A-100000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 08:33:34AM -0400, Bill Davidsen wrote:

>   Other than a few things reporting wrong numbers, what costs do you
> anticipate? I have servers in six USA states (four timezones) and I
> haven't seen any real ill-effect on this.

I have been advised by Alan to treat the jiffy wraparound as a scheduled
maintenance event. I tend to trust bearded kernel hackers from Wales.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
