Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266247AbUARHEl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 02:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266249AbUARHEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 02:04:41 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:21919 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S266247AbUARHEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 02:04:40 -0500
Date: Sat, 17 Jan 2004 23:03:48 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, colpatch@us.ibm.com,
       akpm@osdl.org, paulus@samba.org
Subject: Re: [PATCH] bitmap parsing routines, version 3
Message-Id: <20040117230348.76d26691.pj@sgi.com>
In-Reply-To: <20040118055233.GA24421@holomorphy.com>
References: <20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115181525.GA31086@tsunami.ccur.com>
	<20040115161732.458159f5.pj@sgi.com>
	<400873EC.2000406@us.ibm.com>
	<20040117063618.GA14829@tsunami.ccur.com>
	<20040117020815.3ac17c46.pj@sgi.com>
	<20040117145545.GA16318@tsunami.ccur.com>
	<20040117153615.GA16385@tsunami.ccur.com>
	<20040117153344.1072ae7c.pj@sgi.com>
	<20040118055233.GA24421@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There has never been any confusion. The slop bits are treated
> consistently as "don't cares".

Hmmm ... you seem to be quite right about the bitmap stuff.
The cpumask stuff that sits on top of this still worries me.

I need to look more closely.  Sorry, Bill.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
