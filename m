Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbUJ2Tja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbUJ2Tja (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbUJ2Tiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:38:50 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:7877 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261607AbUJ2TDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:03:34 -0400
Message-ID: <418293F3.5050108@nortelnetworks.com>
Date: Fri, 29 Oct 2004 13:03:15 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
CC: Manu Abraham <manu@kromtek.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
References: <MDEHLPKNGKAHNMBLJOLKAEGFPGAA.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEGFPGAA.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

> 	This position is conditioned on two facts, either:
> 
> 	1) Linus does not distribute his BK tree, or
> 
> 	2) Linus' BK tree is not a derivative work of the Linux kernel
> 
> 	If both of these are false, then the tree must be covered by the GPL. I
> think 2 is clearly false.

The linux tree is certainly a derivative work of itself.  The more important 
(and much more difficult) question is whether the metadata about the tree is a 
derivative work under the rules of the GPL, or whether it is mere aggregation.

I think you could make a compelling argument that the linux kernel history 
metadata is *not* covered under the GPL, and hence can be restricted by licensing.

Chris
