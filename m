Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278381AbRKAI1H>; Thu, 1 Nov 2001 03:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278396AbRKAI05>; Thu, 1 Nov 2001 03:26:57 -0500
Received: from punch.eidetica.com ([62.58.2.8]:43178 "EHLO punch.eidetica.com")
	by vger.kernel.org with ESMTP id <S278381AbRKAI0q>;
	Thu, 1 Nov 2001 03:26:46 -0500
Date: Thu, 1 Nov 2001 09:26:39 +0100
From: Alexander Kellett <kelletta@eidetica.com>
To: Chris Tracy <ctracy@adiemus.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-ac2/3/5: Strange cache memory report
Message-ID: <20011101092639.A27900@punch.eidetica.com>
Mail-Followup-To: Chris Tracy <ctracy@adiemus.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0111010007160.10052-100000@adiemus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0111010007160.10052-100000@adiemus.org>; from ctracy@adiemus.org on Thu, Nov 01, 2001 at 12:23:31AM -0800
X-Disclaimer: My opinions do not necessarily represent those of my employer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 12:23:31AM -0800, Chris Tracy wrote:
> Hey,
> 
> 	I've noticed a strange bug in 2.4.13-ac2, 3, and 5.  (It wasn't
> there in 2.4.12-ac2)  Namely, shortly after starting X, the reported
> amount of cached memory spikes to somewhere around 18 hexabytes.
> Needless to say, I don't have this much memory.  :-)

Rik posted a patch yesterday to fix this.

mvg,
Alex

-- 
Eidetica                                           kelletta@eidetica.com
Kruislaan 400                               tel +31 20 888 4090 fax 4001
NL 1098 SM Amsterdam                            Home machine: myp.ath.cx
http://www.eidetica.com/                     Alexander Kellett (Lypanov)

vim: tw=70 cindent!
