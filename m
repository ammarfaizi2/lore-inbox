Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261621AbVCCMBB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261621AbVCCMBB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 07:01:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVCCLKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 06:10:22 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:422 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S261592AbVCCKvB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:51:01 -0500
Date: Thu, 3 Mar 2005 20:50:13 +1000
From: David McCullough <davidm@snapgear.com>
To: James Morris <jmorris@redhat.com>
Cc: Fruhwirth Clemens <clemens@endorphin.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, cryptoapi@lists.logix.cz,
       Michal Ludvig <michal@logix.cz>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] CryptoAPI: prepare for processing multiple buffers at a time
Message-ID: <20050303105013.GE453@beast>
References: <20050120033019.GD9407@beast> <Xine.LNX.4.44.0501200844530.952-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Xine.LNX.4.44.0501200844530.952-100000@thoron.boston.redhat.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin James Morris lays it down ...
> On Thu, 20 Jan 2005, David McCullough wrote:
> 
> > As for permission to use a dual license,  I will gladly approach the
> > authors if others feel it is important to know the possibility of it at this
> > point,
> 
> Please do so.  It would be useful to have the option of using an already
> developed, debugged and analyzed framework.

Ok,  I finally managed to get responses from all the individual
contributors,  though none of the corporations contacted have responded.

While a good number of those contacted were happy to dual-license,  most
are concerned that changes made under the GPL will not be available for
use in BSD.  A couple were a definate no.

I have had offers to rewrite any portions that can not be dual-licensed,
but I think that is overkill for now unless there is significant
interest in taking that path.

Fortunately we have been able to obtain some funding to complete a large
amount of work on the project so it should have some nice progress in the
next couple of weeks as that ramps up :-)

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
