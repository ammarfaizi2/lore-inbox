Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262914AbVCDNfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbVCDNfB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 08:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVCDNak
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 08:30:40 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4875 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262898AbVCDNZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 08:25:48 -0500
Date: Fri, 4 Mar 2005 13:25:35 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>
Cc: Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
       jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304132535.A9133@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Andrew Morton <akpm@osdl.org>, davej@redhat.com, torvalds@osdl.org,
	jgarzik@pobox.com, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302230634.A29815@flint.arm.linux.org.uk> <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <01ef01c520b7$94bebf80$0f01a8c0@max>; from rpurdie@rpsys.net on Fri, Mar 04, 2005 at 12:40:30PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 12:40:30PM -0000, Richard Purdie wrote:
> I've found the arm cross compiler generated from openembedded 
> (http://openembedded.org) to be very reliable. The big advantage in using oe 
> would be that it is in active use so it is always highly likely to generate 
> a working compiler. Someone just needs to make it generate a 
> toolchain/compiler for external use[1], make it available somewhere and 
> advertise the fact its available. Generation of the toolchain could probably 
> be almost entirely automated.
> 
> Fixes for any problems with compiler would be more than welcome for 
> incorporation into oe short term and for submission upstream for "proper" 
> fixing.

I'll only believe it when I see it.  The problem is this "someone"...
Who's going to forfill that space and produce some results?

Something tells me that we'll be very lucky to get a volunteer, let
alone see any results.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
