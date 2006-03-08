Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWCHAPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWCHAPo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 19:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWCHAPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 19:15:44 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:39815
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S964815AbWCHAPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 19:15:43 -0500
Date: Tue, 07 Mar 2006 16:15:00 -0800 (PST)
Message-Id: <20060307.161500.59628589.davem@davemloft.net>
To: 76306.1226@compuserve.com
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Document Linux's memory barriers
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <200603071819_MC3-1-BA15-3119@compuserve.com>
References: <200603071819_MC3-1-BA15-3119@compuserve.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chuck Ebbert <76306.1226@compuserve.com>
Date: Tue, 7 Mar 2006 18:17:19 -0500

> In-Reply-To: <31492.1141753245@warthog.cambridge.redhat.com>
> 
> On Tue, 07 Mar 2006 17:40:45 +0000, David Howells wrote:
> 
> > The attached patch documents the Linux kernel's memory barriers.
> 
> References:

Here are some good ones for Sparc64:

The SPARC Architecture Manual, Version 9
    Chapter 8: Memory Models
    Appendix D: Formal Specification of the Memory Models
    Appendix J: Programming with the Memory Models

UltraSPARC Programmer Reference Manual
    Chapter 5: Memory Accesses and Cacheability
    Chapter 15: Sparc-V9 Memory Models

UltraSPARC III Cu User's Manual
    Chapter 9: Memory Models

UltraSPARC IIIi Processor User's Manual
    Chapter 8: Memory Models

UltraSPARC Architecture 2005
    Chapter 9: Memory
    Appendix D: Formal Specifications of the Memory Models

UltraSPARC T1 Supplment to the UltraSPARC Architecture 2005
    Chapter 8: Memory Models
    Appendix F: Caches and Cache Coherency
