Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313918AbSDPVfA>; Tue, 16 Apr 2002 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313919AbSDPVe7>; Tue, 16 Apr 2002 17:34:59 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:53196 "HELO
	outpost.powerdns.com") by vger.kernel.org with SMTP
	id <S313918AbSDPVe6>; Tue, 16 Apr 2002 17:34:58 -0400
Date: Tue, 16 Apr 2002 23:34:57 +0200
From: bert hubert <ahu@ds9a.nl>
To: Olaf Fraczyk <olaf@navi.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416233457.A1731@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Olaf Fraczyk <olaf@navi.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <20020416074748.GA16657@venus.local.navi.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2002 at 08:12:22AM +0000, Olaf Fraczyk wrote:
> Hi,
> I would like to know why exactly this value was choosen.
> Is it safe to change it to eg. 1024? Will it break anything?
> What else should I change to get it working:
> CLOCKS_PER_SEC?
> Please CC me.

Your uptime wraps to zero after 49 days. I think 'top' gets confused.

Regards,

bert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
