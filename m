Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270428AbUJTW7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270428AbUJTW7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269112AbUJTWzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:55:17 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:15755 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S270588AbUJTWvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:51:05 -0400
Message-ID: <4176EBD8.3050306@verizon.net>
Date: Wed, 20 Oct 2004 18:51:04 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Structural changes for Documentation directory
References: <4176CFE3.2030306@verizon.net> <20041020153058.6de41ed8.akpm@osdl.org>
In-Reply-To: <20041020153058.6de41ed8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [209.158.211.53] at Wed, 20 Oct 2004 17:51:04 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jim Nelson <james4765@verizon.net> wrote:
> 
>>I propose changing the structure of the Documentation directory to 
>>reflect the structure of the kernel sources itself.
> 
> 
> That sounds like a bit of overdesign, really.  Take it one step at a time.
> 
> Sure, if you're really prepared to do a large-scale overhaul then the first
> step is to create a new top-level directory, say
> "./non-crappy-Documentation" and then move files over into there as they
> are fixed up.  That way we have a good handle on what is done and what
> remains.  You can then make decisions about the directory structure
> on an incremental basis as you become more familiar with the problem.
> 
> 

True.  "./2.6-docs" would reflect the the intent of having 
version-specific information, with the "./Documentation" directory left 
for general information and files of historical interest.

>>Perhaps it would be best to put the new tree in place and have the 
>>individual maintainers relocate their documentation to the new 
>>structure?
> 
> 
> Maintainers studiously ignore the Documentation directory.  If someone
> really wishes to get in there and fix it all up, that person gets to decide
> what goes where and that person gets to harrass various other maintainers
> when assistance is needed.
> 
> 

Well, it is necessary.  Probably the best job for a polite Southern boy 
like me :D

