Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264272AbTH1VgH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 17:36:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbTH1VgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 17:36:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42963 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264272AbTH1VgF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 17:36:05 -0400
Message-ID: <3F4E75B5.4020401@pobox.com>
Date: Thu, 28 Aug 2003 17:35:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Bryan O'Sullivan" <bos@keyresearch.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [ANNOUNCE] netplug, a daemon that handles network cables getting
 plugged in and out
References: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
In-Reply-To: <1062105712.12285.78.camel@serpentine.internal.keyresearch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bryan O'Sullivan wrote:
> Netplug is a daemon that responds to network cables being plugged in or
> out by bringing a network interface up or down.  This is extremely
> useful for DHCP-managed systems that move around a lot, such as laptops
> and systems in cluster environments.
> 
> For more details and download instructions, see the netplug homepage:
> http://www.red-bean.com/~bos/


Does it make use of the link status notification stuff in 2.6.x?  ;-)

	Jeff



