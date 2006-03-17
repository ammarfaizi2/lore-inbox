Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750982AbWCQR1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750982AbWCQR1f (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWCQR1f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:27:35 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:35817 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750982AbWCQR1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:27:34 -0500
Message-ID: <441AF93C.6040407@overtag.dk>
Date: Fri, 17 Mar 2006 19:00:28 +0100
From: Benjamin Bach <benjamin@overtag.dk>
User-Agent: Mail/News 1.5 (X11/20060304)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Idea: Automatic binary driver compiling system
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

First off: I'm new on this list. I'm also new at starting projects. 
Anyways, I've decided on this idea for my first year computer science 
project. I have three months to set it off and definitely the whole 
thing would be released into the world afterwards.

Second: I don't want opinions on the issue of making it easier for 
companies to create binary (pre-compiled) drivers. Yes, we all want more 
open source drivers. Of course.

OK, so here goes: According to Distrowatch there's currently 377 
different distributions out. We have multiple architectures and fresh 
kernel patches every week. If we multiply these numbers, we'd find that 
a company wanting to release a closed-source driver module for Linux 
would face - say - 5,000 compilations a month. Impossible. So most 
companies just release largely incompatible binary drivers in a 
frustratingly limited variety.

I've been looking around for material about the topic of binary Linux 
drivers and creating such in a broad-scale batch mode. But I haven't 
found any. Oh yes, except for Documentation/stable_api_nonsens.txt which 
I found very helpful. But the issue is not having a stable interface - 
rather it is about having a good debugging and building tool that 
handles very very large amounts of kernel versions and patches.

I would be very grateful for pointers to any helpful resource and also 
thoughts on what problems I'm facing. Also I'm aware that this is 
probably not the first time "batch module compiling" has been mentioned... ?

Sincerely,
Benjamin Bach
