Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965219AbWHXAUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbWHXAUX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 20:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965222AbWHXAUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 20:20:23 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21259 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S965219AbWHXAUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 20:20:22 -0400
Date: Thu, 24 Aug 2006 02:20:20 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dax Kelson <dax@gurulabs.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, Theodore Bullock <tbullock@nortel.com>,
       robm@fastmail.fm, brong@fastmail.fm, erich@areca.com.tw, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: Areca arcmsr kernel integration for 2.6.18?
Message-ID: <20060824002020.GH19810@stusta.de>
References: <00a701c6b2b4$bb564b50$0e00cb0a@robm> <25E284CCA9C9A14B89515B116139A94D0C78805F@zrtphxm0.corp.nortel.com> <20060731200309.bd55c545.akpm@osdl.org> <1154530428.3683.0.camel@mulgrave.il.steeleye.com> <1156375551.4306.10.camel@mentorng.gurulabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1156375551.4306.10.camel@mentorng.gurulabs.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2006 at 05:25:51PM -0600, Dax Kelson wrote:
> On Wed, 2006-08-02 at 10:53 -0400, James Bottomley wrote:
> > On Mon, 2006-07-31 at 20:03 -0700, Andrew Morton wrote:
> > > > Ok, so how does this go from here into the mainline kernel?
> > > 
> > > James has moved the driver into the scsi-misc tree, so I assume he has
> > > 2.6.19 plans for it.
> > 
> > Yes, that's the usual path for scsi-misc.
> > 
> > James
> 
> It would be great if the arcmsr driver could be included in 2.6.18 so it
> can make into all the new distro releases that will be happening the
> last 3-4 months of the year.
> 
> It is completely self contained and it isn't changing any existing code
> (ergo it can't break anything) so I believe there is quite a bit of
> precedence for "late" inclusion in 2.6.18?
>...

It would for sure create a bad example for other people trying to get
code merged outside the merge window...

> Dax Kelson

cu
Adrian

-- 

    Gentoo kernels are 42 times more popular than SUSE kernels among
    KLive users  (a service by SUSE contractor Andrea Arcangeli that
    gathers data about kernels from many users worldwide).

       There are three kinds of lies: Lies, Damn Lies, and Statistics.
                                                    Benjamin Disraeli

