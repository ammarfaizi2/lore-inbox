Return-Path: <linux-kernel-owner+w=401wt.eu-S1030258AbXADXCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbXADXCj (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:02:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbXADXCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:02:38 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:3102 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030258AbXADXCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:02:37 -0500
X-Greylist: delayed 1782 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 18:02:37 EST
Date: Thu, 4 Jan 2007 17:14:23 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: wireless Q
Message-ID: <20070104221418.GA5684@tuxdriver.com>
References: <200701040051.51930.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701040051.51930.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 12:51:49AM -0500, Gene Heskett wrote:

> I bought a Belkin Wireless G card, a pci 802-11 radio of some sort.
> 
> The main chip on it wears the label "RTL8185L"
> 
> Is there any support for making this a wireless server in the kernel at 
> the present time?
> 
> I have visions of sticking it in the last pci slot of a box running DD-WRT 
> if there is a driver available.

Gene,

There is no such driver in the kernel at this time.  There is an
out-of-kernel driver available here:

	http://rtl8180-sa2400.sourceforge.net/

YMMV.

FWIW, I know of at least one person working on a driver for the
d80211-based stack in wireless-dev.  I'm not sure when that will be
available publicly.

Hth!

John
-- 
John W. Linville
linville@tuxdriver.com
