Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266496AbUFUWdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266496AbUFUWdb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:33:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266502AbUFUWdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:33:31 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:22671 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S266496AbUFUWch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:32:37 -0400
Message-ID: <40D76200.4080804@nortelnetworks.com>
Date: Mon, 21 Jun 2004 18:32:32 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: BUG?:   G5 not using all available memory
References: <1087855279.22687.33.camel@gaston>
In-Reply-To: <1087855279.22687.33.camel@gaston>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2004-06-21 at 16:11, Chris Friesen wrote:
>  > I've got a G5 with 2GB of memory, running 2.6.7, ppc architecture 
> (not ppc64),
>  > with the following config options (let me know if others are relevent)
> 
> Do you have CONFIG_HIGHMEM enabled ?

Yes, CONFIG_HIGHMEM is turned on.  I can send you the full config if you like.

Sorry, missed including that in the report.

Chris
