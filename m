Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVDNOeY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVDNOeY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 10:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVDNOeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 10:34:24 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:58539 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261512AbVDNOeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 10:34:21 -0400
Date: Thu, 14 Apr 2005 10:34:20 -0400
To: aeriksson@fastmail.fm
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support...
Message-ID: <20050414143420.GR521@csclub.uwaterloo.ca>
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org> <20050413193924.GN521@csclub.uwaterloo.ca> <20050413205949.E987A240480@latitude.mynet.no-ip.org> <20050414124226.GQ521@csclub.uwaterloo.ca> <20050414133523.6D747240480@latitude.mynet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050414133523.6D747240480@latitude.mynet.no-ip.org>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 03:35:22PM +0200, aeriksson@fastmail.fm wrote:
> It's an AOPEN  DUW1608/ARR 
> http://usa.aopen.com/products/dvd+rw/DUW1608ARR.htm
> 
> Should I consider changing it? (I got an 'if this doesn't run on Linux 
> I can trade it in' warranty at the shop)

Well there is a cdwrite mailing list hosted on lists.debian.org which is
a great place to figure out what weird errors are and such, and the
authors of the programs used for writing discs are on thoses lists too,
so you may want to ask for advice there.

Did you try writing using ide-scsi mode with growisofs ?  Any
difference?  Does dvd+rw-media return anything with a disc in the drive?

> I noticed a firmware upgrade on the web page (.exe) will try to get a 
> dos disk running... Sigh...

It might require windows.  Certainly their firmware updates mostly seem
to cover 'improved media coverage'.

I have only been buying the plextor drives personally, since I have
never had a problem with a plextor drive yet, and I like not needing
windows to update the firmware and I find I save time by spending a bit
more on getting the best hardware I can reasonably afford.

Len Sorensen
