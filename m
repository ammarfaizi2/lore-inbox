Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269896AbRHJDCl>; Thu, 9 Aug 2001 23:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269897AbRHJDCb>; Thu, 9 Aug 2001 23:02:31 -0400
Received: from [64.162.95.164] ([64.162.95.164]:55450 "EHLO
	ssh.chaoticdreams.org") by vger.kernel.org with ESMTP
	id <S269896AbRHJDCT>; Thu, 9 Aug 2001 23:02:19 -0400
Date: Thu, 9 Aug 2001 19:59:45 -0700
From: Paul Mundt <lethal@ChaoticDreams.ORG>
To: James Simmons <jsimmons@transvirtual.com>
Cc: Louis Garcia <louisg00@bellsouth.net>, Steven Walter <srwalter@yahoo.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: ATI frame buffer
Message-ID: <20010809195945.A26029@ChaoticDreams.ORG>
In-Reply-To: <997395178.8772.5.camel@tiger> <Pine.LNX.4.10.10108091524520.24524-100000@transvirtual.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.10.10108091524520.24524-100000@transvirtual.com>; from jsimmons@transvirtual.com on Thu, Aug 09, 2001 at 03:25:44PM -0700
Organization: Chaotic Dreams Development Team
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2001 at 03:25:44PM -0700, James Simmons wrote:
> > The docs for the aty128fb states that it only supports the Rage128 based
> > devices. You sure it's also for the radeon?
> 
> aty128fb does NOT work for the radeon cards!!! Their is a radeonfb.c
> driver out their somewhere. I have seen it before.
> 
There is indeed a radeonfb. It's in Alan's tree, has been for awhile.

Regards,

-- 
Paul Mundt <lethal@chaoticdreams.org>

