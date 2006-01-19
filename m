Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbWASP2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbWASP2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 10:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161235AbWASP2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 10:28:14 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:13578 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1161226AbWASP2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 10:28:13 -0500
Date: Thu, 19 Jan 2006 10:27:46 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
       softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
Subject: Re: [Bcm43xx-dev] wireless: the contenders
Message-ID: <20060119152741.GA12344@tuxdriver.com>
Mail-Followup-To: Johannes Berg <johannes@sipsolutions.net>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jbenc@suse.cz,
	softmac-dev@sipsolutions.net, bcm43xx-dev@lists.berlios.de
References: <20060118200616.GC6583@tuxdriver.com> <1137629980.4385.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137629980.4385.9.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 01:19:40AM +0100, Johannes Berg wrote:
> On Wed, 2006-01-18 at 15:06 -0500, John W. Linville wrote:
> 
> > The tree also has "softmac" and "dscape" branches.  The "softmac"
> > branch includes the Johannes Berg softmac code as well as the the
> > BCM43xx driver based upon that code.
> 
> I guess that branch also contains my enhancements to ieee80211, do you
> have any intentions of pulling those over to your upstream tree? I
> suppose I should rather post them as a series of patches to netdev for
> wider consideration.

I pulled from the softmac-2.6.git tree.  I think there was ieee80211
stuff in there as well, but you probably know better than I do. :-)

The history in your tree isn't formatted properly for the kernel,
so something would have to be done before that went upstream anyway.
I think it would be best for you to post the patches to netdev,
including patches covering softmac if you are so inclined.  Please be
sure to follow kernel patch posting conventions:

	http://linux.yyz.us/patch-format.html

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
