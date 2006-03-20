Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030362AbWCTVXu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030362AbWCTVXu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 16:23:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030377AbWCTVXu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 16:23:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:37795 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030362AbWCTVXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 16:23:49 -0500
Date: Tue, 21 Mar 2006 08:23:27 +1100
From: Nathan Scott <nathans@sgi.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-xfs@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Parenthesize macros in xfs
Message-ID: <20060321082327.B653275@wobbly.melbourne.sgi.com>
References: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0603202207310.20060@yvahk01.tjqt.qr>; from jengelh@linux01.gwdg.de on Mon, Mar 20, 2006 at 10:09:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2006 at 10:09:31PM +0100, Jan Engelhardt wrote:
> Hello xfs list,

Hi Jan,

> while browsing through the xfs/linux source, I noticed that many macros do 
> not do proper bracing. I have started to cook up a patch, but would like 
> feedback first before I continue for nothing.
> It goes like this:
> ...

That looks fine.  Please be sure to work on the -mm tree or on
CVS on oss.sgi.com, so as to reduce your level of patch conflict.

thanks.

-- 
Nathan
