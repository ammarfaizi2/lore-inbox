Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWHQJGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWHQJGx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWHQJGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:06:53 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:12804 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932355AbWHQJGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:06:53 -0400
Date: Thu, 17 Aug 2006 11:06:51 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andreas Steinmetz <ast@domdv.de>
Cc: Arjan van de Ven <arjan@infradead.org>, Willy Tarreau <w@1wt.eu>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       mtosatti@redhat.com, Mikael Pettersson <mikpe@it.uu.se>
Subject: Re: Linux 2.4.34-pre1
Message-ID: <20060817090651.GP7813@stusta.de>
References: <20060816223633.GA3421@hera.kernel.org> <20060816235459.GM7813@stusta.de> <20060817051616.GB13878@1wt.eu> <1155797331.4494.17.camel@laptopd505.fenrus.org> <44E42A4C.4040100@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E42A4C.4040100@domdv.de>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2006 at 10:35:24AM +0200, Andreas Steinmetz wrote:
> Arjan van de Ven wrote:
> > But maybe it's worth doing a user survey to find out what the users of
> > 2.4 want... (and with that I mean users of the kernel.org 2.4 kernels,
> > people who use enterprise distro kernels don't count for this since
> > they'll not go to a newer released 2.4 anyway)
> 
> Currently I'm working with ARM based embedded systems. I prefer 2.4
> kernels to 2.6 as they are smaller thus leaving more flash for jffs2.
>...

In this case, kernel 2.4 is a workaround, not a solution, and the 
solution is to get kernel 2.6 as small as kernel 2.4.

Can you send me the .config's you are using for 2.4 and 2.6 
(preferably for kernel.org kernels)?

> Andreas Steinmetz

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

