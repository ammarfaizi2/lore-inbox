Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261497AbULTMl6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261497AbULTMl6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:41:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbULTMl6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:41:58 -0500
Received: from [62.206.217.67] ([62.206.217.67]:52876 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261499AbULTMl4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:41:56 -0500
Message-ID: <41C6DB68.30607@trash.net>
Date: Mon, 20 Dec 2004 15:02:16 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Einar_L=FCck?= <lkml@einar-lueck.de>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH 1/2] ipv4 routing: splitting of ip_route_[in|out]put_slow,
 2.6.10-rc3
References: <41C6B3D4.6060207@einar-lueck.de>
In-Reply-To: <41C6B3D4.6060207@einar-lueck.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Einar Lück wrote:
> [PATCH 1/2] ipv4 routing: splitting of ip_route_[in|out]put_slow, 
> 2.6.10-rc3
> 
> From: Einar Lueck <lkml@einar-lueck.de>
> 
> This patch splits up ip_route_[in|out]put_slow in inlined functions.
> Basic idea:
> * improve overall comprehensibility
> * allow for an easier application of patch for improved multipath 
>  support (refer to the subsequent patch)
> 
> Please consider for application.

Your patches have once again been made unreadable by
your email-client. Please send them again as attachments.

Regards
Patrick
