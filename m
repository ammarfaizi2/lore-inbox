Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262644AbVCXSHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262644AbVCXSHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 13:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbVCXSHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 13:07:18 -0500
Received: from ns1.lanforge.com ([66.165.47.210]:10131 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S262644AbVCXSHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 13:07:14 -0500
Message-ID: <424301CD.4060807@candelatech.com>
Date: Thu, 24 Mar 2005 10:07:09 -0800
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Egger <de@axiros.com>
CC: linux-kernel List Kernel Mailing <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: PCI interrupt problem: e1000 & Super-Micro X6DVA motherboard
References: <42421FF2.7050501@candelatech.com> <9538d4ed18eab6ae1983ce32f7564237@axiros.com>
In-Reply-To: <9538d4ed18eab6ae1983ce32f7564237@axiros.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Egger wrote:

> The card is still in the system and running, so if someone wants
> me to run to more tests or diagnostic, please be my guest.

What does:  ethtool -t eth0
show?

Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

