Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316965AbSFFNXG>; Thu, 6 Jun 2002 09:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSFFNXF>; Thu, 6 Jun 2002 09:23:05 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:8 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S316953AbSFFNXE>; Thu, 6 Jun 2002 09:23:04 -0400
Date: Thu, 6 Jun 2002 17:22:30 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Patrick Mochel <mochel@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, anton@samba.org,
        linux-kernel@vger.kernel.org
Subject: Re: [2.5.19] Oops during PCI scan on Alpha
Message-ID: <20020606172230.A5963@jurassic.park.msu.ru>
In-Reply-To: <20020605182316.B3437@jurassic.park.msu.ru> <Pine.LNX.4.33.0206051653310.654-100000@geena.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 05:01:30PM -0700, Patrick Mochel wrote:
> > Real life example: jensen running generic alpha kernel.
> 
> That's fine. That's exactly the same thing that happens with device
> drivers you have compiled in but don't have hardware for and have hotplug
> enabled. The fact that it's registered with the system simply advertises
> its support.

Ok, this makes sense.

Ivan.
