Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275697AbRIZXvQ>; Wed, 26 Sep 2001 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275705AbRIZXvG>; Wed, 26 Sep 2001 19:51:06 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:4110 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275697AbRIZXvD>;
	Wed, 26 Sep 2001 19:51:03 -0400
Date: Wed, 26 Sep 2001 16:46:43 -0700
From: Greg KH <greg@kroah.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, crispin@wirex.com,
        linux-security-module@wirex.com
Subject: Re: Binary only module overview
Message-ID: <20010926164643.B21369@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0109261743400.27586-100000@terbidium.openservices.net> <E15mMhP-00021p-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15mMhP-00021p-00@the-village.bc.nu>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 10:58:35PM +0100, Alan Cox wrote:
> 
> Given the SSSCA we have to be very clear on this issue, and if its not clear
> I might be best to kill the entire uncertainty by not including the LSM
> patch in Linux until the US government returns to sanity

Or place some kind of markings on the symbols/functions that the LSM
code exports stating that these symbols/functions can only be called
from GPL licensed code.

But to do that, it would require the cooperation of all of the LSM
authors :)

thanks,

greg k-h
