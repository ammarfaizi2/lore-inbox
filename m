Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269901AbUIDLqR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269901AbUIDLqR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 07:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269898AbUIDLqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 07:46:17 -0400
Received: from shockwave.systems.pipex.net ([62.241.160.9]:29883 "EHLO
	shockwave.systems.pipex.net") by vger.kernel.org with ESMTP
	id S269906AbUIDLlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 07:41:45 -0400
Message-ID: <4139A9F4.4040702@tungstengraphics.com>
Date: Sat, 04 Sep 2004 12:41:40 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@yahoo.com>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
References: <20040904004424.93643.qmail@web14921.mail.yahoo.com> <Pine.LNX.4.58.0409040145240.25475@skynet> <20040904102914.B13149@infradead.org> <41398EBD.2040900@tungstengraphics.com> <20040904104834.B13362@infradead.org> <413997A7.9060406@tungstengraphics.com> <20040904112535.A13750@infradead.org> <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
In-Reply-To: <20040904112930.GB2785@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Sat, Sep 04, 2004 at 11:30:54AM +0100, Keith Whitwell wrote:
> 
>  > >>Sure, explain to me how I should upgrade my RH-9 system to work on my new 
>  > >>i915?
>  > >
>  > >Download a new kernel.org kernel or petition the fedora legacy folks to
>  > >include a drm update.  The last release RH-9 kernel has various security
>  > >and data integrity issues anyway, so you'd be a fool to keep running it.
>  > 
>  > OK, I've found www.kernel.org, and clicked on the 'latest stable kernel' 
>  > link. I got a file called "patch-2.6.8.1.bz2".  I tried to install this 
>  >  but nothing happened.  My i915 still doesn't work.  What do I do now?
> 
> Tungsten might like to think your end users are morons, but we like to
> believe our end-users (ie, ANYONE building their own kernel) have
> a small amount of common sense. 

Please don't think that I'm talking for Tungsten at this or any other time on 
the DRI list.  I'm talking for myself and have never attempted to convey here 
or elsewhere a "company" view without explictly flagging it up as such. 
Apologies if the use of a TG mailing address is confusing, but I will have to 
continue using it for the meantime as it is the one subscribed to this list.

Likewise, are you making a RedHat statement that you believe that your 
endusers need to be able to compile a kernel to use your products, or is that 
a statement of a regular LK developer?  I'm sure you appreciate the parallel.

But in general, yes, I'd like to think that you don't have to have even heard 
of a compiler in order to be able to install a video driver...

I don't see why installing a DRI driver should be more difficult than 
installing an NV, ATI or even a windows driver...

I don't see why it should be necessary to reboot a machine just to update it's 
video driver...

Keith
