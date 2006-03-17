Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752225AbWCQASA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752225AbWCQASA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751913AbWCQASA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:18:00 -0500
Received: from mail.dvmed.net ([216.237.124.58]:48052 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751324AbWCQAR7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:17:59 -0500
Message-ID: <441A0035.4040506@garzik.org>
Date: Thu, 16 Mar 2006 19:17:57 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, cramerj@intel.com,
       john.ronciak@intel.com
Subject: Re: [PATCH]: e1000 endianness bugs
References: <20060315.142628.28661597.davem@davemloft.net>
In-Reply-To: <20060315.142628.28661597.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> 	return -E_NO_BIG_ENDIAN_TESTING;
> 
> [E1000]: Fix 4 missed endianness conversions on RX descriptor fields.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

applied


