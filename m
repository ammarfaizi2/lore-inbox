Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262617AbSKGOFk>; Thu, 7 Nov 2002 09:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266547AbSKGOFk>; Thu, 7 Nov 2002 09:05:40 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:51416 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262617AbSKGOFj>;
	Thu, 7 Nov 2002 09:05:39 -0500
Date: Thu, 7 Nov 2002 15:12:19 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IPSEC FIRST LIGHT! (by non-kernel developer :-))
Message-ID: <20021107141219.GA28791@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <20021107103905.GA22139@outpost.ds9a.nl> <20021107.025250.35525477.davem@redhat.com> <20021107130244.GA25032@outpost.ds9a.nl> <20021107.052114.123991710.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107.052114.123991710.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 05:21:14AM -0800, David S. Miller wrote:
>    From: bert hubert <ahu@ds9a.nl>
>    Date: Thu, 7 Nov 2002 14:02:44 +0100
>    
>    Great work everybody! I'm very impressed.
> 
> Thanks for testing :-)

No problem! By the way, is tunnel mode there yet?

Does it require more than setkey? Or does it need pseudo devices, GRE or
anything? Just setting up tunnel mode doesn't appear to work - nothing gets
crypted or signed.

Regards,

bert


-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
