Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263629AbUEGPtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263629AbUEGPtZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 11:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbUEGPtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 11:49:25 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:62603 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S263629AbUEGPtW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 11:49:22 -0400
Subject: Re: [ANNOUNCE] [PATCH] Node Hotplug Support
From: Dave Hansen <haveblue@us.ibm.com>
To: Keiichiro Tokunaga <tokunaga.keiich@jp.fujitsu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hotplug devel <linux-hotplug-devel@lists.sourceforge.net>,
       lhns-devel@lists.sourceforge.net
In-Reply-To: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
References: <20040508003904.63395ca7.tokunaga.keiich@jp.fujitsu.com>
Content-Type: text/plain
Message-Id: <1083944945.23559.1.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 07 May 2004 08:49:05 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-07 at 08:39, Keiichiro Tokunaga wrote:
> First of all, I'd like to discuss the design of node hotplug and
> interface with hotplug folks.  After I get feedback from the people,
> I'll update my patches.  Also I'll release the following features in
> the near future.  Then I'll make them work all together and test
> them.
> 
>   - NUMA node support
>   - ACPI based memory hotplug
>   - ACPI based IO hotplug
>   - H2P bridge hotplug
>   - P2P brdige hotplug
>   - IOSAPIC hotplug

How does this interoperate with the current NUMA topology already in
sysfs today?  I don't see any references at all to the current code.  

-- Dave

