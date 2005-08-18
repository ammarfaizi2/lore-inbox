Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbVHRWzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbVHRWzp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVHRWzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 18:55:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:9423 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932514AbVHRWzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 18:55:43 -0400
Date: Fri, 19 Aug 2005 08:55:29 +1000
From: Nathan Scott <nathans@sgi.com>
To: Russell Cattelan <cattelan@thebarn.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-xfs@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [xfs-masters] Re: [PATCH] pull XFS support out of Kconfig submenu
Message-ID: <20050819085529.A4075975@wobbly.melbourne.sgi.com>
References: <200508172245.49043.jesper.juhl@gmail.com> <20050818135356.GA16845@taniwha.stupidest.org> <1124378546.25069.107.camel@naboo.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1124378546.25069.107.camel@naboo.americas.sgi.com>; from cattelan@thebarn.com on Thu, Aug 18, 2005 at 10:22:26AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2005 at 10:22:26AM -0500, Russell Cattelan wrote:
> .. fs/xfs/Kconfig but using submenu was simply a convince thing 
> to group all the XFS options together.

s/convince/convenience/

> If the submenu is really causing people distress go ahead and 
> remove it. Since it's a cosmetic change it's not going to impact
> anything.

Yep, I guess we should just queue this up for 2.6.14.

cheers.

-- 
Nathan
