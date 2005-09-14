Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965123AbVINJpe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965123AbVINJpe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965125AbVINJpe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:45:34 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:36995 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S965123AbVINJpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:45:33 -0400
Message-ID: <4327EE94.2040405@kromtek.com>
Date: Wed, 14 Sep 2005 13:34:12 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PCI driver
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been in the process of trying to write a new PCI driver. The 
hardware is Memory Mapped IO device similar to the Fusion 878, but not 
that complicated, but simpler

Now that i have been trying to implement the driver using the new PCI 
API, i feel a bit lost at the different changes gone into the PCI API. 
So if someone could give me a brief idea how a minimal PCI probe routine 
should consist of, that would be quite helpful.

Thanks,
Manu
