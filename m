Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVLHKsm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVLHKsm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 05:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbVLHKsm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 05:48:42 -0500
Received: from main.gmane.org ([80.91.229.2]:23947 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750831AbVLHKsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 05:48:41 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dirk Steuwer <dirk@steuwer.de>
Subject: Re: Linux Hardware Quality Labs (was: Linux in a binary world... a doomsday scenario)
Date: Thu, 8 Dec 2005 10:46:04 +0000 (UTC)
Message-ID: <loom.20051208T113436-719@post.gmane.org>
References: <6DAD0850-4943-416E-9E7B-095C6B412DD0@oxley.org> <4397E427.2070702@laposte.net> <6A700AF6-1E1B-49A7-A565-336700882097@oxley.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 213.61.178.52 (Mozilla/5.0 (Windows; U; Windows NT 5.0; de-DE; rv:1.7.12) Gecko/20050919 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I presume that drivers will be developed alongside the hardware  
> because you can't sell the kit until the drivers are on the CD in the  
> nice box with the instruction manual.

It wil be real "plug and play". The driver is not in the hardwarebox, its in 
the linux/bsd/whatever kernel. 
Ideally, people with the right kernel stick the hardware in and it just works.
No driver installation involved. This is an important aspect, that currently
nobody out there links to linux. If you ask someone why they not use linux
its hardware problems - mostly on desktop/laptop. But any free operation system
with free drivers should be known for an "instant run" of supported hardware.
No more driver installation worries is a fantastic side effect of free drivers.


> Also you can't test the hardware properly unless you have drivers for  
> it.
> 

The hardware vendor has to provide 
a) documentation of the interface
b) samples to maybe three kernel developers for review

if three developers certify that it works, the overlooking Org. can release 
the logo to be included on the box.
If the vendor is not cooperating alongside hardware development, the inital box
with css drivers will go into market, and only later a linux sticker is added.


