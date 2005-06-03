Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVFCNgA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVFCNgA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 09:36:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVFCNgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 09:36:00 -0400
Received: from dvhart.com ([64.146.134.43]:20647 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S261263AbVFCNfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 09:35:54 -0400
Date: Fri, 03 Jun 2005 06:35:43 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Denis Vlasenko <vda@ilport.com.ua>,
       linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>,
       Adam Litke <agl@us.ibm.com>, Enrique Gaona <egaona@us.ibm.com>
Subject: Re: [ANNOUNCE] automated linux kernel testing results
Message-ID: <367110000.1117805742@[10.10.2.4]>
In-Reply-To: <200506031612.30638.vda@ilport.com.ua>
References: <531740000.1117749798@flay> <200506031612.30638.vda@ilport.com.ua>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--Denis Vlasenko <vda@ilport.com.ua> wrote (on Friday, June 03, 2005 16:12:30 +0300):

> On Friday 03 June 2005 01:03, Martin J. Bligh wrote:
>> OK, I've finally got this to the point where I can publish it.
>> 
>> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/abat/regression_matrix.html
>> 
>> Currently it builds and boots any mainline, -mjb, -mm kernel within
>> about 15 minutes of release. runs dbench, tbench, kernbench, reaim and fsx.
>> Currently I'm using a 4x AMD64 box, a 16x NUMA-Q, 4x NUMA-Q, 32x x440 (ia32)
>> PPC64 Power 5 LPAR, PPC64 Power 4 LPAR, and PPC64 Power 4 bare metal system.
>> The config files it uses are linked by the machine names in the column 
>> headers.
> 
> Wow. 8]
> 
> Some (but not all) green links like [GOOD 4550] lead to 404 land. Is this intended?

Nope, it's buggered. Some of the new ones are not replicating out properly.
Fixing it ...

M.

