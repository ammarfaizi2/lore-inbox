Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290520AbSAQWzE>; Thu, 17 Jan 2002 17:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290523AbSAQWyz>; Thu, 17 Jan 2002 17:54:55 -0500
Received: from [63.204.6.12] ([63.204.6.12]:26842 "EHLO mail.somanetworks.com")
	by vger.kernel.org with ESMTP id <S290520AbSAQWyp>;
	Thu, 17 Jan 2002 17:54:45 -0500
Date: Thu, 17 Jan 2002 17:54:14 -0500
From: "Mark Frazer" <mark@somanetworks.com>
To: Andi Kleen <ak@muc.de>
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru, netdev@oss.sgi.com,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] new sysctl net/ipv4/ip_default_bind
Message-ID: <20020117175414.A2187@somanetworks.com>
In-Reply-To: <20020117172713.A1893@somanetworks.com> <20020117234103.A2797@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020117234103.A2797@averell>; from ak@muc.de on Thu, Jan 17, 2002 at 11:41:03PM +0100
X-Message-Flag: Lookout!
Organization: Detectable, well, not really
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doh.  I was using the old SIOCADDRT to add routes and such.  Off to
learn rtnetlink...

thanks
-mark

Andi Kleen <ak@muc.de> [02/01/17 17:42]:
> You can already do that using the 'from' attribute in iproute2
> aka prefered source address per route. Just set it for your default
> route.
> 
> -Andi

-- 
"we are like unbaked soma vessels"
