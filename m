Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266892AbUGVSos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266892AbUGVSos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 14:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266893AbUGVSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 14:44:48 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:29693 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266892AbUGVSoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 14:44:46 -0400
Date: Thu, 22 Jul 2004 11:44:44 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: Cam <camilo@mesias.co.uk>
Cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.20_mvl31 OOPS ip_route_input called within ip_rt_init
Message-ID: <20040722184444.GA6270@plexity.net>
Reply-To: dsaxena@plexity.net
References: <40FFFF10.2000902@mesias.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40FFFF10.2000902@mesias.co.uk>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 22 2004, at 18:53, Cam was caught saying:
> Hi,
> 
> I have an embedded ppc linux which sometimes can oops at boot time if it 
> receives a packet during ip_rt_init. There is a printk in there in the 
> middle of initialisation of rt_hash_table which can introduce a delay 
> which makes the problem more likely to happen,

_Please_ do not send questions for vendor-supplied and supported kernels
to this list. If you have this kernel, you are probably a MVista
customer and you should go ask their support folks.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment and
 will die here like rotten cabbages." - Number 6
