Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132250AbRCWADu>; Thu, 22 Mar 2001 19:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132245AbRCWABX>; Thu, 22 Mar 2001 19:01:23 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:61950 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S132246AbRCVX7t>;
	Thu, 22 Mar 2001 18:59:49 -0500
Date: Thu, 22 Mar 2001 15:59:06 -0800
To: Junfeng Yang <yjf@stanford.edu>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Re : [CHECKER] 28 potential interrupt errors
Message-ID: <20010322155906.B13215@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <20010322153641.B13162@bougret.hpl.hp.com> <Pine.GSO.4.31.0103221543240.29011-100000@epic8.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0103221543240.29011-100000@epic8.Stanford.EDU>; from yjf@Stanford.EDU on Thu, Mar 22, 2001 at 03:49:31PM -0800
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 03:49:31PM -0800, Junfeng Yang wrote:
> 
> Sometimes the line number reported by the checker is not correct.
> But if you go into the function, you can find the bug.

	Gotcha. It in fact indicate the error at the end of the
function instead of the place where the error is. Very confusing.
	So, mea culpa, I was wrong...

	Jean
