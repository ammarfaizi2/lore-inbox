Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264976AbRFUOFK>; Thu, 21 Jun 2001 10:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264977AbRFUOFA>; Thu, 21 Jun 2001 10:05:00 -0400
Received: from elektra.higherplane.net ([203.37.52.137]:20154 "EHLO
	elektra.higherplane.net") by vger.kernel.org with ESMTP
	id <S264976AbRFUOEm>; Thu, 21 Jun 2001 10:04:42 -0400
Date: Fri, 22 Jun 2001 00:21:26 +1000
From: john slee <indigoid@higherplane.net>
To: Matthias Urlichs <smurf@noris.de>
Cc: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>,
        Balbir Singh <balbir_soni@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
Message-ID: <20010622002126.K30872@higherplane.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p05100304b757adbbacd1@[10.2.6.42]>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2001 at 03:58:33PM +0200, Matthias Urlichs wrote:
> At 23:50 +1000 2001-06-21, john slee wrote:
> >i believe libgpio uses the existing usb/iee1394/serial/parallel
> >interfaces to provide a limited userspace driver capability.
> 
> That only means, however, that the specific kernel drivers explicitly
> support mid-level usermode access.
> 
> They still handle the actual hardware state changes without usermode support.

yes, that was the point.  while it might be a stretch of the "mechanism,
not policy" argument, i like having drivers organized this way.  it
makes a lot of sense for hotpluggable things like usb.

j.

-- 
"Bobby, jiggle Grandpa's rat so it looks alive, please" -- gary larson
