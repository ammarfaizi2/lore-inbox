Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261403AbTCZGO5>; Wed, 26 Mar 2003 01:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261438AbTCZGO5>; Wed, 26 Mar 2003 01:14:57 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40452 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261403AbTCZGO4>;
	Wed, 26 Mar 2003 01:14:56 -0500
Date: Tue, 25 Mar 2003 22:25:18 -0800
From: Greg KH <greg@kroah.com>
To: Brad Hards <bhards@bigpond.net.au>
Cc: Eric Wong <eric@yhbt.net>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [PATCH] Logitech USB mice/trackball extensions
Message-ID: <20030326062517.GB21390@kroah.com>
References: <20030326022938.GA5187@bl4st.yhbt.net> <20030326034841.GA20858@kroah.com> <20030326040946.GB13242@BL4ST> <200303261654.08896.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303261654.08896.bhards@bigpond.net.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 04:54:08PM +1100, Brad Hards wrote:
> On Wed, 26 Mar 2003 15:09, Eric Wong wrote:
> > Greg KH <greg@kroah.com> wrote:
> > > On Tue, Mar 25, 2003 at 07:03:30PM -0800, Eric Wong wrote:
> > > > Oops, ignore this part, it's part of a separate patch :)
> > >
> > > Can you send me an updated patch?
> Doing it in kernel space with module options is gross. This is clearly a case 
> for userspace.
> 
> See: http://www.linmagau.org/modules.php?name=Sections&op=viewarticle&artid=40

Sweet, nice job.

Sorry, Eric, I'll not apply this patch, as the userspace implementation
makes much more sense.

thanks,

greg k-h
