Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262973AbVCDSls@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262973AbVCDSls (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbVCDSlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:41:47 -0500
Received: from dialin-161-58.tor.primus.ca ([216.254.161.58]:50069 "EHLO
	node1.opengeometry.net") by vger.kernel.org with ESMTP
	id S262973AbVCDSgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:36:06 -0500
Date: Fri, 4 Mar 2005 13:35:51 -0500
From: William Park <opengeometry@yahoo.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304183551.GA4175@node1.opengeometry.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050303151752.00527ae7.akpm@osdl.org> <20050303234523.GS8880@opteron.random> <20050303160330.5db86db7.akpm@osdl.org> <20050304025746.GD26085@tolot.miese-zwerge.org> <20050303213005.59a30ae6.akpm@osdl.org> <1109924470.4032.105.camel@tglx.tec.linutronix.de> <20050304005450.05a2bd0c.akpm@osdl.org> <20050304091612.GG14764@suse.de> <20050304012154.619948d7.akpm@osdl.org> <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0503040956420.25732@ppc970.osdl.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 09:57:38AM -0800, Linus Torvalds wrote:
> I've long since decided that there's no point to making "-pre". What's
> the difference between a "-pre" and a daily -bk snapshot? Really?
> 
> So when I do a release, it _is_ an -rc. The fact that people have
> trouble understanding this is not _my_ fault.

My feeling is that there is too many numbers in the kernel version.  
I think 3 numbers are good enough to get people to try out (knowingly or
not).  So,
    2.6.{11,12,13,...} -- for testing (a.k.a. -rc, -pre)
    2.7 -- stable release
    2.7.{1,2,3,...} -- for testing
    2.8 -- another stable release
    ...
    2.125 -- when last IDE bug is fixed.
    3.0 -- stable release
    3.0.{1,2,3,...} -- for testing
    ...
