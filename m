Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVC2XBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVC2XBq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:01:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVC2XBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:01:46 -0500
Received: from fire.osdl.org ([65.172.181.4]:7572 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261617AbVC2XBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:01:44 -0500
Message-ID: <4249DD83.80600@osdl.org>
Date: Tue, 29 Mar 2005 14:58:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "L. A. Walsh" <lkml@tlinx.org>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RFC: 2.6.release.patchlevel:  Patch against 2.6.release[.0] ?
References: <4249DC03.4000806@tlinx.org>
In-Reply-To: <4249DC03.4000806@tlinx.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L. A. Walsh wrote:
> Given the frequency with which stabilization patches may be released, it
> may not be practical to expect users to catch each release announcement
> and download each patch.
> 
> Especially if small patches are released for stability, as one might
> (hopefully) expect.  Assuming that stability and "fix-it" patches will
> generally be small (I'd hope).  Seeing that the latest "fix-it" patch
> is already at ".6", I'd have to load multiple patches to catch up from
> 2.6.11.  I blinked my eyes and missed a few or 5 previous stability
> patches, so I just downloaded the entire bzip...not a biggie, but
> might create less load on servers if I didn't need to go through 6
> patch applications to get current.
> 
> What do people think?  Would it be desirable to have the stability
> patchsets based against the base release (2.6.11 in this case)?  I'll
> already have downloaded 2.6.11 or the previous base release, but
> with the frequency of patch releases, it might be more reasonable to
> have patch revisions all patch against a base release rather than
> having to download and apply what may grow to be a large number (but
> small diff) against a base release?
> 
> Do people think patch-releases will get too big, or might it not
> be easier to apply them to a constant downloaded copy of the base?
> 
> It's a bit amusing since I was one of those that complained about the
> kernel stability, but 2.6.11 has been fairly solid for me, so, of course,
> I'm 6 patches behind -- I don't think the patch release notifications
> are getting as wide-spread press (or at least not reaching "/." :-)) as
> the main releases get.

After some initial discussions, the patches now are generated against
2.6.x.0, so to get to 2.6.11.6, you only need to download and apply
one patchset...

-- 
~Randy
