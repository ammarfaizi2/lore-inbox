Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWE3H0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWE3H0n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 03:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932176AbWE3H0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 03:26:43 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:47539 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S932165AbWE3H0m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 03:26:42 -0400
Date: Tue, 30 May 2006 10:26:36 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Andrew Morton <akpm@osdl.org>
cc: jesse@icplus.com.tw, romieu@fr.zoreil.com, dvrabel@cantab.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       david@pleyades.net
Subject: Re: Sign-off for the IP1000A driver before inclusion
In-Reply-To: <20060529234610.e5671e4c.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0605301024440.22126@sbz-30.cs.Helsinki.FI>
References: <84144f020605230001s32b29f59w8f95c67fad7b380d@mail.gmail.com>
 <044a01c67ef8$9bdd0420$4964a8c0@icplus.com.tw>
 <Pine.LNX.4.58.0605240911400.26629@sbz-30.cs.Helsinki.FI>
 <021f01c683b0$34b5cbd0$4964a8c0@icplus.com.tw>
 <Pine.LNX.4.58.0605300915400.18933@sbz-30.cs.Helsinki.FI>
 <20060529234610.e5671e4c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2006, Andrew Morton wrote:
> It takes people quite a few iterations to get patch preparation worked out.
> 
> Pekka, if you have time, perhaps you can extract the patches for us?

Jesse, I wasn't able to work out the ipg_config_autoneg() changes, but the 
rest of them are at:

  http://www.cs.helsinki.fi/u/penberg/linux/ip1000-jesse/

They're missing changelogs, though, so I'd much appreciate if Jesse 
submitted them properly to Francois who's maintaining the ipg git tree.

				Pekka 
