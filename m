Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270669AbTGNSsC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270660AbTGNSsB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:48:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33156 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270669AbTGNSr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:47:58 -0400
Message-ID: <3F12FE4B.2070004@pobox.com>
Date: Mon, 14 Jul 2003 15:02:35 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: David griego <dagriego@hotmail.com>
CC: alan@storlinksemi.com, linux-kernel@vger.kernel.org
Subject: Re: Alan Shih: "TCP IP Offloading Interface"
References: <Sea2-F18ekWo76UaiRN00008964@hotmail.com>
In-Reply-To: <Sea2-F18ekWo76UaiRN00008964@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David griego wrote:
> IMHO, there are several cases for some type of TCP/IP offload.  One is 
> for embedded systems that are just not capable of doing 1Gbps+.  Another 
> is with 10GbE, even high end servers will not be able keep up with TCP 
> processing/data movement at these speeds.  Not being proactive in 
> adopting TCP/IP offload will force Linux into accepting some scheme that 
> will not necissarily be best.


How does one evaluate a TOE stack to be sure that all the security fixes 
in Linux are also in that stack?

How does one evaluate a TOE stack to be sure it doesn't add new security 
holes that Linux never had?

	Jeff



