Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCLI0M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 03:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbUCLI0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 03:26:12 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:59384 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S262029AbUCLI0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 03:26:10 -0500
From: Richard Browning <richard@redline.org.uk>
Organization: Redline Software Engineering
To: Len Brown <len.brown@intel.com>
Subject: Re: SMP + Hyperthreading / Asus PCDL Deluxe / Kernel 2.4.x 2.6.x / Crash/Freeze
Date: Fri, 12 Mar 2004 08:24:31 +0000
User-Agent: KMail/1.6
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615F4B99@hdsmsx402.hd.intel.com> <1079072878.3885.33.camel@dhcppc4> <1079075236.3885.52.camel@dhcppc4>
In-Reply-To: <1079075236.3885.52.camel@dhcppc4>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403120824.31859.richard@redline.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 12 March 2004 07:07, Len Brown wrote:
> Hmm, read that note too fast...
> Since the failure did not follow the package to the BSP socket
> (CPU0/CPU1), but instead stayed with the AP (CPU2/CPU3) socket, that
> suggests an issue with the MB rather than the processor itself.

But how is it possible that simply activating HT could cause this error? Is it 
not the BIOS/processor that determines HT support ... it operates correctly 
in SMP mode. Hm.

R
