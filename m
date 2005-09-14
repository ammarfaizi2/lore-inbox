Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932260AbVINKOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932260AbVINKOQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 06:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932262AbVINKOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 06:14:16 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:38615 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S932260AbVINKOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 06:14:15 -0400
Message-ID: <4327F551.6070903@kromtek.com>
Date: Wed, 14 Sep 2005 14:02:57 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Manu Abraham <manu@kromtek.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI driver
References: <4327EE94.2040405@kromtek.com> <4327F586.3030901@gmail.com>
In-Reply-To: <4327F586.3030901@gmail.com>
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

Jiri Slaby wrote:

> Manu Abraham napsal(a):
>
>> Now that i have been trying to implement the driver using the new PCI 
>> API, i feel a bit lost at the different changes gone into the PCI 
>> API. So if someone could give me a brief idea how a minimal PCI probe 
>> routine should consist of, that would be quite helpful.
>
>
> Maybe, you want to read http://lwn.net/Kernel/LDD3/, chapter 12, pages 
> 311+.
>

I have been updating myself from LDD2 to LDD3. What i was wondering was 
in what order should i be calling the functions.


Thanks,
Manu

