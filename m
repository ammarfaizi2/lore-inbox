Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWHCDDI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWHCDDI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 23:03:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWHCDDI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 23:03:08 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:14290 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932136AbWHCDDH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 23:03:07 -0400
Message-ID: <44D1675E.5090803@in.ibm.com>
Date: Thu, 03 Aug 2006 08:32:54 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM India Private Limited
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.5) Gecko/20060720 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Jay Lan <jlan@sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
References: <44CE57EF.2090409@sgi.com>	<44CF6433.50108@in.ibm.com>	<44CFCCE4.7060702@sgi.com>	<44D0C56C.3030505@watson.ibm.com>	<44D0DE13.7090205@in.ibm.com> <20060802140945.de650d95.akpm@osdl.org>
In-Reply-To: <20060802140945.de650d95.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Aug 2006 22:47:07 +0530
> Balbir Singh <balbir@in.ibm.com> wrote:
> 
>> I am not sure if there is a version of BUG_ON() for compile time
>> asserts
> 
> We have BUILD_BUG_ON()

Thanks, I remember that we had something similar, but was lost
looking for it in asm-*/bug.h.

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
