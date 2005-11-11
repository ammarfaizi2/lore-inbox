Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932324AbVKKDMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324AbVKKDMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 22:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbVKKDMD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 22:12:03 -0500
Received: from mail15.syd.optusnet.com.au ([211.29.132.196]:57747 "EHLO
	mail15.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932324AbVKKDMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 22:12:01 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Peter Williams <pwil3058@bigpond.net.au>
Subject: Re: [PATCH] plugsched - update Kconfig
Date: Fri, 11 Nov 2005 14:11:55 +1100
User-Agent: KMail/1.8.3
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Han <xiphux@gmail.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Jake Moilanen <moilanen@austin.ibm.com>
References: <434F01EA.6060709@bigpond.net.au> <200511111405.33762.kernel@kolivas.org>
In-Reply-To: <200511111405.33762.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511111411.55829.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 02:05 pm, Con Kolivas wrote:
> Hi Peter et al
>
> I find the Kconfig menu layout a little confusing and suggest the following
> patch.

Actually I changed my mind about the first part. If you deselect plugsched you 
need some way of selecting the default scheduler, sorry. I'll spin up a patch 
with just the spa submenu.

Cheers,
Con
