Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291172AbSBVWub>; Fri, 22 Feb 2002 17:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293036AbSBVWuV>; Fri, 22 Feb 2002 17:50:21 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27257 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293033AbSBVWuJ>; Fri, 22 Feb 2002 17:50:09 -0500
Date: Fri, 22 Feb 2002 17:49:59 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Dave Rattay [ITeX]" <Dave.Rattay@itexinc.com>
Cc: Stephan von Krawczynski <skraw@ithnet.com>, alan@lxorguk.ukuu.org.uk,
        egberts@yahoo.com, lkml@secureone.com.au, linux-kernel@vger.kernel.org,
        ITeX Tech Support <techsupport@itexinc.com>
Subject: Re: Dlink DSL PCI Card
Message-ID: <20020222174959.A16169@redhat.com>
In-Reply-To: <E788BA1D236784409F3F7138F1EABFDDE4DF@iteusa-nt.itexinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E788BA1D236784409F3F7138F1EABFDDE4DF@iteusa-nt.itexinc.com>; from Dave.Rattay@itexinc.com on Fri, Feb 22, 2002 at 02:33:48PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 02:33:48PM -0800, Dave Rattay [ITeX] wrote:
> Stephan,
> 
>     I am not sure if you actually requesting anything but here are some
> points on this matter.  First and foremost we do not make these cards.
> They are made by our customers that we supply chips for.  We do make the
> drivers for these boards but they can then be customized by our
> customers.  The point is that we do support Linux for our customers and
> our customers are not really end-users.  Now since end-users are
> indirectly our customers we do supply Linux drivers on request.  Also if
> we cannot meet a request for any reason that information is added to our
> Marketing data for future driver development.  Due to previous licensing
> agreements we cannot release our source code to anyone including our
> direct customers and there is no way around that.  Sorry.  Now if you
> have a request for a driver please let me know the kernel version being
> used as well as the ADSL protocol that you have.  I will see what I can
> do to get you a usable driver.

You're missing the point.  We as developers want the specifications for 
the hardware as we're completely willing to write our own driver from 
scratch.  Until Itex is able to provide this to developers, products 
based on your chipsets will remain not recommended for Linux users as 
it will continually result in a poor user experience.

		-ben
