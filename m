Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267690AbTBGFFh>; Fri, 7 Feb 2003 00:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267716AbTBGFFh>; Fri, 7 Feb 2003 00:05:37 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:24083 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267690AbTBGFFg>;
	Fri, 7 Feb 2003 00:05:36 -0500
Date: Thu, 6 Feb 2003 21:10:39 -0800
From: Greg KH <greg@kroah.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: [RFC] klibc for 2.5.59 bk
Message-ID: <20030207051039.GA30639@kroah.com>
References: <20030207045919.GA30526@kroah.com> <3E433EBC.5000202@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E433EBC.5000202@zytor.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 09:06:04PM -0800, H. Peter Anvin wrote:
> Greg KH wrote:
> >Hi all,
> >
> >Thanks to Arnd Bergmann, it looks like the klibc and initramfs code is
> >now working.  I've created a patch against Linus's latest bk tree and
> >put it at:
> >	http://www.kroah.com/linux/klibc/klibc-2.5.59-2.patch.gz
> >(I can't get to kernel.org right now, sorry)
> >and there's a bk tree at:
> >	bk://kernel.bkbits.net/gregkh/linux/klibc-2.5
> >
> >I'd really like to send this to Linus now, but I'm going to be away
> >from email for about a week, so I'll wait will I get back.  If anyone
> >has any issues with this patch, please let me know.
> >
> 
> That's good, that'll give me a chance to check through it.
> 
> What klibc is this based on?

klibc-0.72  
Ugh, I see you've now released a few versions since then :(
I'll sync up to the latest version before sending the patch on to Linus,
thanks for making me look.

thanks,

greg k-h
