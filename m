Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbTJCBvo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263586AbTJCBvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:51:44 -0400
Received: from [66.212.224.118] ([66.212.224.118]:11017 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S263584AbTJCBvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:51:41 -0400
Date: Thu, 2 Oct 2003 21:51:34 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: AG <agroz@spe.midco.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test5 & test6 cd burning/scheduler/ide-scsi.c bug
In-Reply-To: <3F7CCEB8.8040803@spe.midco.net>
Message-ID: <Pine.LNX.4.53.0310022146120.2108@montezuma.fsmlabs.com>
References: <3F7CCEB8.8040803@spe.midco.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Oct 2003, AG wrote:

> Hi 
> 
>  This is my first bug submission, so please have patience with my noobness :)

The general consensus is that you should be using the direct ATAPI 
interface for cd-writing in 2.6. Be sure to get uptodate cdrtools and if 
you want to use a gui, i hear k3b is able to grok the new interface. 

You may find the following URL of interest, most notably the "CD 
Recording" section.

http://www.codemonkey.org.uk/post-halloween-2.5.txt

Good luck
