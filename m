Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290115AbSAXU0A>; Thu, 24 Jan 2002 15:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290138AbSAXUZk>; Thu, 24 Jan 2002 15:25:40 -0500
Received: from waste.org ([209.173.204.2]:33956 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290115AbSAXUZb>;
	Thu, 24 Jan 2002 15:25:31 -0500
Date: Thu, 24 Jan 2002 14:25:25 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Alexander Viro <viro@math.psu.edu>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.GSO.4.21.0201241522140.21209-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.44.0201241424190.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Alexander Viro wrote:

> On Thu, 24 Jan 2002, Oliver Xymoron wrote:
>
> > Because you never test against X==true. You always test X!=false. This is
> > the C way.
>
> ITYM "You always test X".

I do indeed, but the bool crowd seems to like making the != explicit for
some reason.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

