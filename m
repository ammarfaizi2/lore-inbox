Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbUDJC4c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 22:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbUDJC4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 22:56:32 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:30606 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261857AbUDJC4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 22:56:31 -0400
Date: Fri, 9 Apr 2004 19:54:19 -0700
From: Paul Jackson <pj@sgi.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: colpatch@us.ibm.com, wli@holomorphy.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch 17/23] mask v2 = [6/7] nodemask_t_ia64_changes
Message-Id: <20040409195419.7fc28631.pj@sgi.com>
In-Reply-To: <200404092304.18621.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040401122802.23521599.pj@sgi.com>
	<200404091054.24618.vda@port.imtp.ilyichevsk.odessa.ua>
	<20040409105349.6b40fe02.pj@sgi.com>
	<200404092304.18621.vda@port.imtp.ilyichevsk.odessa.ua>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if it is used in some time critical place, adding call overhead

I'm not disagreeing with anything you note.  I was just
stating that I didn't claim the expertise for such decisions. 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
