Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313194AbSDJPBH>; Wed, 10 Apr 2002 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313201AbSDJPBG>; Wed, 10 Apr 2002 11:01:06 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:61338 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S313194AbSDJPAu>; Wed, 10 Apr 2002 11:00:50 -0400
Date: Wed, 10 Apr 2002 11:00:48 -0400
From: Lennert Buytenhek <buytenh@gnu.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, bridge@math.leidenuniv.nl,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "David S. Miller" <davem@redhat.com>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [BUG] DEADLOCK when removing a bridge on 2.4.19-pre6
Message-ID: <20020410150048.GA32501@gnu.org>
In-Reply-To: <20020410015311.GA31952@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Apr 09, 2002 at 06:53:11PM -0700, Mike Fedyk wrote:

> 2.4.16,17 work just fine, but 2.4.18 does not.  Looking through the
> changelog, 2.4.18-pre4, or 5 look suspect.  Also, it is not fixed in
> 2.4.19-pre6.  I can test the 2.4.18-pre kernels if you'd like, just let me
> know.

There's a detailed list of patches that went into 2.4 at:

	http://bridge.sourceforge.net/patchtracker.html

Can you try and find out which of the three patches that went
into 2.4.18 is causing your problems?


thanks,
Lennert
