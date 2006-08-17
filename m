Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWHQXgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWHQXgJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 19:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbWHQXgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 19:36:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39321 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030391AbWHQXgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 19:36:06 -0400
Date: Thu, 17 Aug 2006 16:35:30 -0700
From: Paul Jackson <pj@sgi.com>
To: Ian Stirling <ian.stirling@mauve.plus.com>
Cc: suresh.b.siddha@intel.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, mingo@redhat.com, apw@shadowen.org
Subject: Re: [patch] sched: group CPU power setup cleanup
Message-Id: <20060817163530.29f8d4ab.pj@sgi.com>
In-Reply-To: <44E4FBC8.1040607@mauve.plus.com>
References: <20060815175525.A2333@unix-os.sc.intel.com>
	<20060815212455.c9fe1e34.pj@sgi.com>
	<20060815214718.00814767.akpm@osdl.org>
	<20060816110357.B7305@unix-os.sc.intel.com>
	<20060817102030.f8c41330.pj@sgi.com>
	<20060817110317.A14787@unix-os.sc.intel.com>
	<20060817121804.e140f19e.pj@sgi.com>
	<44E4FBC8.1040607@mauve.plus.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian wrote:
> I'd suggest 'computing_power' might be less ambiguous.

Eh ... I should quit suggesting names, until I figure
out more accurately what it means.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
