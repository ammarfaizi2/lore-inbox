Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVAGTPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVAGTPY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 14:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVAGTOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 14:14:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15540 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261531AbVAGTLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 14:11:42 -0500
Message-ID: <41DEDEE5.5020908@pobox.com>
Date: Fri, 07 Jan 2005 14:11:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Netdev <netdev@oss.sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: netdev-2.6 queue updated
References: <41DE73B5.6080303@pobox.com> <20050107190426.GA17017@electric-eye.fr.zoreil.com>
In-Reply-To: <20050107190426.GA17017@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> [...]
> 
>>  o r8169: oversized driver field for ethtool
>>  o r8169: reduce max MTU for large frames
>>  o r8169: Large Send enablement
>>  o r8169: C 101
>>  o r8169: missing netif_poll_enable and irq ack
> 
> 
> Imho you can push these changes to mainline (with due credit to
> Jon D Mason for its contributions).

Yep, it's going in the next batch.  Most of netdev-2.6 is bound for 
mainline "soon".

	Jeff



