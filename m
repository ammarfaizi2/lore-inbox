Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbUCLAci (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 19:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUCLAci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 19:32:38 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:39702 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S261862AbUCLAcg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 19:32:36 -0500
Message-Id: <5.1.0.14.2.20040312102918.04336368@mira-sjcm-3.cisco.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 12 Mar 2004 10:32:29 +1000
To: Timothy Miller <miller@techsource.com>
From: Lincoln Dale <ltd@cisco.com>
Subject: Re: [Announce] Intel PRO/Wireless 2100 802.11b driver
Cc: Jeff Garzik <jgarzik@pobox.com>, vda <vda@port.imtp.ilyichevsk.odessa.ua>,
       Dax Kelson <dax@gurulabs.com>,
       James Ketrenos <jketreno@linux.co.intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <404F50E7.4090907@techsource.com>
References: <404ED404.4050604@pobox.com>
 <404E27E6.40200@linux.co.intel.com>
 <1078866774.2925.15.camel@mentor.gurulabs.com>
 <200403101015.19506.vda@port.imtp.ilyichevsk.odessa.ua>
 <404ED404.4050604@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:31 AM 11/03/2004, Timothy Miller wrote:
>Hmmm...  As you may know, I'm a chip designer...
>
>Are there not open specs on the wireless protocols?  Could we not design 
>our own open-source wireless network hardware?  What would the US 
>government have to say about an open-source implementation?  Are there 
>patents which would impede us?

the issue is one of "current generation" radio units, as used in 
802.11a/b/g are typically very programmable, and in many cases, can both 
send & receive on frequencies well outside of the standard 802.11a/b/g 
2.4GHz and 5.4GHz bands.

i'd hazard a guess and say that this is the primary reason for the concern 
in releasing true "open source" for the firmware.
potentially, the equipment could be used outside of the range of 
frequencies that it is intended for (and indeed FCC certified for).

i know of at least one radio that can snoop other frequencies such as 
police/emergency services/ ...


cheers,

lincoln.

