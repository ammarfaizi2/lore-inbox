Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261517AbVDNUem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261517AbVDNUem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 16:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbVDNUem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 16:34:42 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:19863 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S261517AbVDNUeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 16:34:31 -0400
Message-ID: <425ED3C9.5090600@candelatech.com>
Date: Thu, 14 Apr 2005 13:34:17 -0700
From: Ben Greear <greearb@candelatech.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ganesh Venkatesan <ganesh.venkatesan@gmail.com>
CC: "netdev@oss.sgi.com" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
References: <42421FF2.7050501@candelatech.com>	 <20050324081003.GA23453@xi.wantstofly.org>	 <42431734.3030905@candelatech.com> <5fc59ff305041411013fd35ed4@mail.gmail.com>
In-Reply-To: <5fc59ff305041411013fd35ed4@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ganesh Venkatesan wrote:

>Ben:
>
>Have you checked if the BIOS on the super micro machine is the latest
>and greatest. I have had interrupt routing issues very similar to the
>one you are describing due to a BIOS Interrupt Routing issue. Moving
>to newer BIOS fixed it.
>  
>

A new BIOS didn't help.  Super-Micro eventually reproduced the problem, 
and told me
the fix was to send the MB back to them so they could solder another part
onto it....  I haven't received the MB back yet so I don't know if they 
really
have a fix for it or not...

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


