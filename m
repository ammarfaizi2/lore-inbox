Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWBSVbO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWBSVbO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 16:31:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932272AbWBSVbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 16:31:14 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64395 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932278AbWBSVa6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 16:30:58 -0500
Date: Mon, 20 Feb 2006 08:30:46 +1100
From: Nathan Scott <nathans@sgi.com>
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RT, OOPS] 2.6.15.3-rt16 + XFS on USB => OOPS
Message-ID: <20060220083045.B9478997@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.60.0602192117530.3700@poirot.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.60.0602192117530.3700@poirot.grange>; from g.liakhovetski@gmx.de on Sun, Feb 19, 2006 at 09:26:06PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2006 at 09:26:06PM +0100, Guennadi Liakhovetski wrote:
> Hi
> 
> Got the following Oops while trying to mount an XFS partition on a USB 
> disk under 2.6.15.3-rt16:

This is fixed in 2.6.15.4.

cheers.

-- 
Nathan
