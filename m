Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271122AbTHHAIa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 20:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271125AbTHHAIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 20:08:30 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:2713 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S271122AbTHHAIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 20:08:21 -0400
Date: Thu, 07 Aug 2003 17:04:27 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jasper Spaans <jasper@vs19.net>
cc: torvalds@osdl.org, andries.brouwer@cwi.nl,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Change all occurrences of 'flavour' to 'flavor'
Message-ID: <3020000.1060301062@[10.10.2.4]>
In-Reply-To: <1060295842.3169.83.camel@dhcp22.swansea.linux.org.uk>
References: <20030807180032.GA16957@spaans.vs19.net> <1060295842.3169.83.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Alan Cox <alan@lxorguk.ukuu.org.uk> wrote (on Thursday, August 07, 2003 23:37:23 +0100):

> On Iau, 2003-08-07 at 19:00, Jasper Spaans wrote:
>> It changes all occurrences of 'flavour' to 'flavor' in the complete tree;
>> I've just comiled all affected files (that is, the config resulting from
>> make allyesconfig minus already broken stuff) succesfully on i386.
> 
> The Linux kernel tended to favour european spelling, and favOUr is
> indeed correct English.

Either way, haven't we stopped piddling around with spelling fixes and
breaking everyone's patches yet? I thought we had ...

M.

