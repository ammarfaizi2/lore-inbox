Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293549AbSCLAI7>; Mon, 11 Mar 2002 19:08:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310227AbSCLAIj>; Mon, 11 Mar 2002 19:08:39 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:56274 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S310223AbSCLAIe>; Mon, 11 Mar 2002 19:08:34 -0500
Date: Tue, 12 Mar 2002 02:08:28 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: zlib vulnerability and modutils
Message-ID: <20020312000828.GB132950@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020311234516.GC128921@niksula.cs.hut.fi> <4394.1015887380@kao2.melbourne.sgi.com> <14719.1015891493@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14719.1015891493@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 12:04:53AM +0000, you [David Woodhouse] wrote:
> 
> vherva@niksula.hut.fi said:
> >  Is there a patch for the kernel ppp zlib implementation available
> > somewhere? I'd like to patch the kernels I'm running rather than
> > stuffing a random vendor kernel to the boxes... 
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/linux-2.4.19-shared-zlib.bz2
> 
> That's a backport of the shared zlib from 2.5.6. As it does all its 
> memory allocation beforehand, I _assume_ it doesn't suffer the same problem.

Thanks.
 
> It may be a little more intrusive than you wanted though.

Quite possibly -- at least considering that some of the kernels I run are
still 2.2.x and even 2.0.x...

I'll have a look anyway.


-- v --

v@iki.fi
