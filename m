Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030272AbVJ1UIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030272AbVJ1UIE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 16:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030289AbVJ1UIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 16:08:04 -0400
Received: from mail.dvmed.net ([216.237.124.58]:46829 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030272AbVJ1UIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 16:08:02 -0400
Message-ID: <4362851A.2070108@pobox.com>
Date: Fri, 28 Oct 2005 16:07:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Leon <santil@us.ibm.com>
CC: Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] ibmveth fix bonding
References: <20051026164532.21820.72673.sendpatchset@localhost.localdomain> <20051026164539.21820.57374.sendpatchset@localhost.localdomain>
In-Reply-To: <20051026164539.21820.57374.sendpatchset@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Leon wrote:
> This patch updates dev->trans_start and dev->last_rx so that the ibmveth
> driver can be used with the ARP monitor in the bonding driver. 
> 
> Signed-off-by: Santiago Leon <santil@us.ibm.com>

applied 1-5


