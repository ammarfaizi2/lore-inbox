Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751059AbVKJQ4l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbVKJQ4l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 11:56:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVKJQ4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 11:56:41 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37590 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751059AbVKJQ4k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 11:56:40 -0500
Message-ID: <43737BBB.3070909@austin.ibm.com>
Date: Thu, 10 Nov 2005 10:56:27 -0600
From: Joel Schopp <jschopp@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050922 Fedora/1.7.12-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ashok Raj <ashok.raj@intel.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@muc.de,
       zwane@arm.linux.org.uk, rusty@rustycorp.com.au, vatsa@in.ibm.com,
       nathanl@austin.ibm.com, anil.s.keshavamurthy@intel.com
Subject: Re: Documentation for CPU hotplug support
References: <20051110075932.A16271@unix-os.sc.intel.com>
In-Reply-To: <20051110075932.A16271@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj wrote:
> Hi Andrew
> 
> CPU hotplug support didnt have a readme for general help.
> 
> Thanks to Andi for some feedback. 
> 
> Consider for -mm so if people have updates they can do when it gets
> up the tree.
> 
> I added authors as much as i can remember, if roles have changed, please
> send updates to this document.
> 

While far from complete (no mention of userspace notification for instance), it 
is a very good start.

Acked-by: Joel Schopp <jschopp@austin.ibm.com>
