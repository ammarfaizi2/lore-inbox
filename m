Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317714AbSGKCLn>; Wed, 10 Jul 2002 22:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317715AbSGKCLm>; Wed, 10 Jul 2002 22:11:42 -0400
Received: from theirongiant.weebeastie.net ([203.62.148.50]:31908 "EHLO
	theirongiant.weebeastie.net") by vger.kernel.org with ESMTP
	id <S317714AbSGKCLm>; Wed, 10 Jul 2002 22:11:42 -0400
Date: Thu, 11 Jul 2002 12:14:02 +1000
From: CaT <cat@zip.com.au>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
Message-ID: <20020711021402.GB5608@zip.com.au>
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <3D2CA6E3.CB5BC420@zip.com.au> <20020710173555.D2005@redhat.com> <3D2CA958.BEE16D98@zip.com.au> <20020710174251.E2005@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020710174251.E2005@redhat.com>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 05:42:51PM -0400, Benjamin LaHaise wrote:
> On Wed, Jul 10, 2002 at 02:38:32PM -0700, Andrew Morton wrote:
> > OK, I'll grant that.  Why is this useful?
> 
> Think video playback, where you want to queue the frame to be played as 
> close to the correct 1/60s time as possible.  With HZ=100, the code will 

Or 1/50 (think PAL), no? (Of course HZ=100 would be sweet for that. ;)

-- 
GOVERNMENT ANNOUNCEMENT - The  government announced  today that  it is
changing its mascot  to a condom because  it more clearly reflects the
government's political stance.  A condom stands up to inflation, halts
production, destroys  the next generation,  protects a bunch of pricks
and finally, gives you a sense of security while you're being screwed!
