Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030380AbWFJNtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030380AbWFJNtp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 09:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWFJNtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 09:49:45 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:11530 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030377AbWFJNto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 09:49:44 -0400
Date: Sat, 10 Jun 2006 15:49:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Mike Snitzer <snitzer@gmail.com>
Cc: Jeff Garzik <jeff@garzik.org>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-fsdevel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, cmm@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
Message-ID: <20060610134946.GC11634@stusta.de>
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com> <20060609091327.GA3679@infradead.org> <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org> <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org> <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org> <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2006 at 02:27:53PM -0400, Mike Snitzer wrote:
> On 6/9/06, Jeff Garzik <jeff@garzik.org> wrote:
> >Jeff Garzik wrote:
> >> I disagree completely...  it would be an obvious win:  people who want
> >> stability get that, people who want new features get that too.
> >
> >And developers have a better outlet for their wacky developmental urges...
> 
> And no real-world near-term progress is made for production users with
> modern requirements. What you're advocating breeds instability in the
> near-term.

There's also the old-fashioned "no regressions" requirement.

You are trading near-term instability for the few users with "modern 
requirements" against possible regressions for a large userbase.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

