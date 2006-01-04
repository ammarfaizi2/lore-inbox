Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbWADXAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbWADXAl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 18:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbWADXAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 18:00:41 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:34079 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751049AbWADXAk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 18:00:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i3LDvEvrQ66Xc7N6olBVFiAq8sMGQAwTXC46qDWxjCGNeFAV0krI45CLyh8QasoYdFgnBo3tjHM00b1sisuznkcI/PCkUgDs6gi57F6ebL9XB1/uiYMOF6cZy2YPACsT1ymonfFOYxAiVu5+tV/hyXx7IjdjDkn4+BJPcaqiMcE=
Message-ID: <4d8e3fd30601041500t20f54dcdpdb6866b7753d1731@mail.gmail.com>
Date: Thu, 5 Jan 2006 00:00:39 +0100
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: userspace breakage
In-Reply-To: <20060103203724.GG5819@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051228214845.GA7859@elte.hu> <20051229073259.GA20177@elte.hu>
	 <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org>
	 <20051229202852.GE12056@redhat.com>
	 <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org>
	 <20051229224103.GF12056@redhat.com>
	 <Pine.LNX.4.64.0512291451440.3298@g5.osdl.org>
	 <20051229230307.GB24452@redhat.com> <20060103202853.GF12617@kroah.com>
	 <20060103203724.GG5819@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/3/06, Dave Jones <davej@redhat.com> wrote:
> On Tue, Jan 03, 2006 at 12:28:53PM -0800, Greg Kroah-Hartman wrote:
>
>  > > I'm glad you agree.  I've decided to try something different once 2.6.16
>  > > is out.  Every day, I'm going to push the -git snapshot of the day into
>  > > a testing branch for Fedora users. (Normally, only rawhide[1] users
>  > > get to test kernel-de-jour, and this always has the latest userspace, so
>  > > we don't notice problems until a kernel point release and the stable
>  > > distro gets an update).
>  >
>  > Ah, nice idea, I'll try to set up the same thing for Gentoo's kernels.
>  > Hopefully the expanded coverage will help...

Greg,
did you manage for doing the same for Gentoo?

If so, what's the approach? Is Gentoo now shipping pre-compiled -git
vanilla kernels as well?

--
Paolo
