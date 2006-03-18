Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932358AbWCRJrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358AbWCRJrV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 04:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWCRJrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 04:47:20 -0500
Received: from fmr20.intel.com ([134.134.136.19]:4587 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S932358AbWCRJrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 04:47:19 -0500
Message-ID: <441BD6F9.8050003@linux.intel.com>
Date: Sat, 18 Mar 2006 10:46:33 +0100
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2 of 8] annotate the PDA structure with offsets
References: <1142611850.3033.100.camel@laptopd505.fenrus.org> <1142611989.3033.107.camel@laptopd505.fenrus.org> <20060318093853.GA28846@elte.hu>
In-Reply-To: <20060318093853.GA28846@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Arjan van de Ven <arjan@linux.intel.com> wrote:
> 
>> Change the comments in the pda structure to make the first fields to 
>> have their offset documented (the rest of the fields follows in a 
>> later patch) and to have the comments aligned
> 
> i think offset 40 should be build-time checked - then you dont have to 
> do this annotation.
> 

ok good idea; I'll investigate
