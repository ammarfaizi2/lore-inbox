Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282093AbRKWJo1>; Fri, 23 Nov 2001 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282094AbRKWJoS>; Fri, 23 Nov 2001 04:44:18 -0500
Received: from pD9538E9E.dip.t-dialin.net ([217.83.142.158]:15613 "EHLO
	tolot.miese-zwerge.org") by vger.kernel.org with ESMTP
	id <S282095AbRKWJoH>; Fri, 23 Nov 2001 04:44:07 -0500
Date: Fri, 23 Nov 2001 10:43:13 +0100
From: Jochen Striepe <jochen@tolot.escape.de>
To: rpjday <rpjday@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is 2.4.15 really available at www.kernel.org?
Message-ID: <20011123094313.GB190@tolot.miese-zwerge.org>
In-Reply-To: <20212.1006507727@ocs3.intra.ocs.com.au> <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111230437180.7283-100000@localhost.localdomain>
User-Agent: Mutt/1.3.23.2i
X-Signature-Color: brightblue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

On 23 Nov 2001, rpjday <rpjday@mindspring.com> wrote:
> 
> i swear, i am not making this up.  i just tried again, through mozilla,
> to download the file 
> www.kernel.org/pub/linux/kernel/v2.4/linux-2.4.15.tar.bz2, and it 
> completed after downloading *exactly* 155312 bytes, just as before.
> 
> getting it via ftp works fine -- it's http that's giving me this
> weird problem.   is it just me?

Getting it via http using wget worked fine here:

-rw-------    1 jochen   users    23747061 Nov 23 07:18 /tmp/linux-2.4.15.tar.bz2


I am *much* more irritated by:

$ uname -r
2.4.15-greased-turkey


So long,

Jochen.

-- 
Think of the mess on the carpet. Sensible people do all their
demon-summoning in the garage, which you can just hose down afterwards.
        -- damerell@chiark.greenend.org.uk
