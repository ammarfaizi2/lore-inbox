Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267650AbUHEL0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267650AbUHEL0K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 07:26:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267646AbUHEL0J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 07:26:09 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:34770 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S267649AbUHELYL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 07:24:11 -0400
Date: Thu, 5 Aug 2004 13:22:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Hector Martin <hector@marcansoft.com>
Cc: Pasi Sjoholm <ptsjohol@cc.jyu.fi>,
       Robert Olsson <Robert.Olsson@data.slu.se>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org,
       netdev@oss.sgi.com, brad@brad-x.com, shemminger@osdl.org
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe RLT-8139 related)
Message-ID: <20040805132233.A7430@electric-eye.fr.zoreil.com>
References: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi> <41120882.40302@marcansoft.com> <41121237.4050305@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <41121237.4050305@marcansoft.com>; from hector@marcansoft.com on Thu, Aug 05, 2004 at 12:55:51PM +0200
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hector Martin <hector@marcansoft.com> :
[...]
> using a stabler TCP/IP stack. This one works OK. No problem so far... 
> anyway, even though it stopped and I had to restart the PS2 some times, 
> the PC has been receiving packets with no reboot whatsoever. I think 
> it's fixed :)

Ok, I'll send the final version of the patches for inclusion in -netdev
and/or -mm this evening. It will provide a broader testing.

--
Ueimor
