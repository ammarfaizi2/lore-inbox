Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSCHA1y>; Thu, 7 Mar 2002 19:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310612AbSCHA1m>; Thu, 7 Mar 2002 19:27:42 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:4617 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290818AbSCHA0j>;
	Thu, 7 Mar 2002 19:26:39 -0500
Date: Thu, 7 Mar 2002 21:26:27 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>, <hch@infradead.org>,
        <phillips@bonn-fries.net>
Subject: Re: 2.4.19pre2aa1
In-Reply-To: <20020308012239.B1356@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203072126100.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Mar 2002, Andrea Arcangeli wrote:

> The result is that it exploits most of the random input, and physically
> consecutive pages are liekly to use the same cacheline in case there is
> some pattern. That looks a good algorithm to me.

Worthy of documentation, even.

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

