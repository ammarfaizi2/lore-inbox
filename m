Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTI2P3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 11:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbTI2P3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 11:29:16 -0400
Received: from fed1mtao05.cox.net ([68.6.19.126]:26536 "EHLO
	fed1mtao05.cox.net") by vger.kernel.org with ESMTP id S263590AbTI2P3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 11:29:13 -0400
Message-ID: <3F784FC3.5090301@backtobasicsmgmt.com>
Date: Mon, 29 Sep 2003 08:29:07 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back to Basics Network Management
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Michal Kochanowicz <michal@michal.waw.pl>, linux-kernel@vger.kernel.org
Subject: Re: What to use with 2.6.x instead of iproute2?
References: <20030927151935.GD5956@wieszak.lan> <3F784CFC.30103@nortelnetworks.com>
In-Reply-To: <3F784CFC.30103@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:

> Is Alexey still the iproute2 maintainer?  Has anyone sent him a patch 
> for 2.6?
> 

There are no patches to iproute2 required to get it to compile against 
2.6 headers; the only patch required was to linux/netdevice.h, which 
has been included in 2.6.0-test6.

However, it would be wonderful if someone knowledgeable could take 
over maintainership of iproute2 if Alexey can no longer do it. It's in 
a sorry state at the moment, and most distros ship significantly 
patched versions.

