Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUGHNxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUGHNxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264991AbUGHNxl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:53:41 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:55959 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265025AbUGHNxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:53:34 -0400
Message-ID: <40ED51BF.8040302@nortelnetworks.com>
Date: Thu, 08 Jul 2004 09:53:03 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Naveen Kumar <naveenkrg@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Adding multicast routes using Netlink sockets
References: <20040708065016.81889.qmail@web41113.mail.yahoo.com>
In-Reply-To: <20040708065016.81889.qmail@web41113.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Naveen Kumar wrote:

> I was trying to check if you can add multicast routes
> to kernel using netlink sockets in a way similar to
> unicast routes.

>  If this is possible, how would you go about giving
> options to the netlink sockets?

The fastest way to figure this out is to see whether it can be done with the 
"ip" command.  If so, then look at the iproute2 source code.

Chris
