Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbTAEHvt>; Sun, 5 Jan 2003 02:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263977AbTAEHvt>; Sun, 5 Jan 2003 02:51:49 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:1540
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S263899AbTAEHvs>; Sun, 5 Jan 2003 02:51:48 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: Andre Hedrick <andre@linux-ide.org>
Subject: Re: Binary drivers and GPL
Date: Sun, 5 Jan 2003 03:01:28 -0500
User-Agent: KMail/1.6
References: <Pine.LNX.4.10.10301042352540.421-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10301042352540.421-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Disposition: inline
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200301050301.28227.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Because when I look at the big picture.

If I look at a group of industries say, SCSI companies (say there are 3 only).

Company A: Releases specs to community to write a driver.

Company B: Refuses to release anything

Company C: Refuses to release anything

Now, because company A has released its specs Company B and C are free to view 
this and use ideas to improve their products thus hurting company A.

Now company A sees the other companies improving the products due to their 
specs being released and decides that all new products will be closed.

Now we have binary-only modules for all SCSI cards and more dependency on 
companies which to me denies me access to newer kernels due to API 
inconsistancies and thus kills my help in kernel development.

THIS is why I'm against binary drivers in the long run.

On Sunday 05 January 2003 2:54 am, Andre Hedrick wrote:
> Shawn,
>
> Why are you against it, and do you know that 2.5/2.6/3.0 has already
> modelled a method to do make it so painful to prevent binarys from being
> useful for the most part?
>
> Andre Hedrick
> LAD Storage Consulting Group
>
> On Sun, 5 Jan 2003, Shawn Starr wrote:
> > Enough is enough! I'm SO tired of hearing this over and over now. But
> > since it's raging on I might as well throw some coal into the fire a
> > little ;-)
> >
> > As much as I would love to see a ban on binary drivers to protect the
> > kernel, this issue isn't going away. Not only that but I'd love to see a
> > module blacklist in which a non-tainted kernel refuses to load binary
> > drivers that are not GPL.
> >
> > We have to make sure that we restrict binary drivers as much as possible
> > because other companies may decide that they don't need to release their
> > specs/sources anymore because binary drivers become the norm and because
> > their competition is also not releasing their specs/code. This I fear is
> > the danger if we go down this road. We can't allow companies to dictate
> > indirectly how a kernel will function.
> >
> > Shawn.
> >
> >
> >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

