Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274232AbRISW27>; Wed, 19 Sep 2001 18:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274233AbRISW2u>; Wed, 19 Sep 2001 18:28:50 -0400
Received: from fabulous.u--3.com ([212.50.142.250]:7632 "HELO
	fabulous.u--3.com") by vger.kernel.org with SMTP id <S274232AbRISW2i>;
	Wed, 19 Sep 2001 18:28:38 -0400
Date: Thu, 20 Sep 2001 01:28:55 +0300
From: Erno Kuusela <erno@iki.fi>
To: Brad Pepers <brad@linuxcanada.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon bug stomper. Pls apply.
Message-ID: <20010920012855.U31911@fabulous.u--3.com>
In-Reply-To: <Pine.LNX.4.33.0109191635310.29593-100000@terbidium.openservices.net> <20010919214317Z274216-760+14235@vger.kernel.org> <01091916225800.23716@dragon.linuxcan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01091916225800.23716@dragon.linuxcan.com>; from brad@linuxcanada.com on Wed, Sep 19, 2001 at 04:22:58PM -0600
Organization: 26-dimensional hypercube
X-PGP-Key-URL: http://212.50.142.250/dsakey.asc - please use it!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,

On Wed, 19 Sep 2001, Brad Pepers wrote:

| I've noticed that on my Athalon 1.4GHz system (Asus A7V133), I get results 
| quite a bit higher than reported here when running the athalon.c program.  
| For example everyone posting seemed to get 4000-5000 cycles per page for the 
| clear_page fuctions "faster_clear_page" and "even_faster_clear" while mine is 
| in the 6300-6700 range.  Does this indicate I'm missing some BIOS 
| optimizations?  Slow memory?  Something else?

you have a faster cpu (but same speed memory) - so more
cycles pass by when doing memory operations.

   -- erno
