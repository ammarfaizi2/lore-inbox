Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261556AbVCaQrf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261556AbVCaQrf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:47:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVCaQrf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:47:35 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:30620 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261556AbVCaQre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:47:34 -0500
Message-ID: <424C2975.2090009@nortel.com>
Date: Thu, 31 Mar 2005 10:46:45 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <randy.dunlap@verizon.net>
CC: ioe-lkml@axxeo.de, matthew@wil.cx, lkml <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [RFC/PATCH] network configs: disconnect network options from
 drivers
References: <20050330234709.1868eee5.randy.dunlap@verizon.net>
In-Reply-To: <20050330234709.1868eee5.randy.dunlap@verizon.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:

> A few people dislike that the Networking Options menu is inside
> the Device Drivers/Networking menu.  This patch moves the
> Networking Options menu to immediately before the Device Drivers menu,
> renames it to "Networking options and protocols", & moves most
> protocols to more logical places (IMHOOC).

<snip>

> Any comments?

Makes sense to me...

Chris

