Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262884AbSJLLML>; Sat, 12 Oct 2002 07:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262885AbSJLLML>; Sat, 12 Oct 2002 07:12:11 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:22710 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S262884AbSJLLML>;
	Sat, 12 Oct 2002 07:12:11 -0400
Date: Sat, 12 Oct 2002 13:17:59 +0200
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] USAGI IPsec
Message-ID: <20021012111759.GA10104@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	linux-kernel@vger.kernel.org, netdev@oss.sgi.com
References: <m3u1js1l1a.wl@karaba.org> <20021011.185332.115906289.davem@redhat.com> <20021012.114330.78212112.yoshfuji@linux-ipv6.org> <20021011.194108.102576152.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021011.194108.102576152.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 11, 2002 at 07:41:08PM -0700, David S. Miller wrote:
>    From: YOSHIFUJI Hideaki / ?$B5HF#1QL@ <yoshfuji@linux-ipv6.org>
>    Date: Sat, 12 Oct 2002 11:43:30 +0900 (JST)
>    
>    Would you tell us the points of the "several details," please?
> 
> We believe that the whole SPD/SAD mechanism should move
> eventually to a top-level flow cache shared by ipv4 and
> ipv6.

Is this the proposed stacked route system?

Regards,

bert hubert

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://www.tk                              the dot in .tk
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
