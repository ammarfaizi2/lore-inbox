Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932532AbVJZELa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932532AbVJZELa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 00:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbVJZEL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 00:11:29 -0400
Received: from mail.dvmed.net ([216.237.124.58]:41941 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932529AbVJZEL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 00:11:29 -0400
Message-ID: <435F01EB.6080608@pobox.com>
Date: Wed, 26 Oct 2005 00:11:23 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Leon <santil@us.ibm.com>
CC: netdev <netdev@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 1/5 ibmveth fix bonding
References: <1130275458.10524.425.camel@localhost.localdomain>
In-Reply-To: <1130275458.10524.425.camel@localhost.localdomain>
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

all patches look OK to me.

all patches except #1 appear to be whitespace-corrupted.

	Jeff



