Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbUCRXWi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 18:22:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263299AbUCRXVz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 18:21:55 -0500
Received: from mail.gmx.de ([213.165.64.20]:42706 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263039AbUCRXNb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 18:13:31 -0500
X-Authenticated: #7370606
Message-ID: <405A2D19.1040901@gmx.at>
Date: Fri, 19 Mar 2004 00:13:29 +0100
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carlos Fernandez Sanz <cfs-lk@nisupu.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Hightpoint chipsets
References: <1Bc9L-4nl-1@gated-at.bofh.it>
In-Reply-To: <1Bc9L-4nl-1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Fernandez Sanz wrote:
> What's the current status of Highpoint RAID drivers, for both 2.4 and 2.6?
> 
> I was using a 2.4 kernel just fine with my HP474 PCI card. I know some
> people had lots of DMA issues with it (I had them as well for some time).
> The thing is, inmediately after I plugged a new USB UPS (to be specific, a
> MGE Premium 800) I started to see those problems.

I am not sure about the HPT374 chipset code status but the RAID-0 
implementation is available for 2.4 and 2.6 as a evms-plugin:
http://marc.theaimsgroup.com/?l=evms-devel&m=107936928618685&w=2

bye,
wilfried
