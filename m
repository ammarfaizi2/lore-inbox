Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbWDVVC5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbWDVVC5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 17:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWDVVC5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 17:02:57 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:5592 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751197AbWDVVC4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 17:02:56 -0400
Subject: Re: [ckrm-tech] [RFC] [PATCH 00/12] CKRM after a major overhaul
From: Matt Helsley <matthltc@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <20060421191340.0b218c81.akpm@osdl.org>
References: <20060421022411.6145.83939.sendpatchset@localhost.localdomain>
	 <1145630992.3373.6.camel@localhost.localdomain>
	 <1145638722.14804.0.camel@linuxchandra>
	 <20060421155727.4212c41c.akpm@osdl.org>
	 <1145670536.15389.132.camel@linuxchandra>
	 <20060421191340.0b218c81.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 21 Apr 2006 19:20:44 -0700
Message-Id: <1145672444.21109.701.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-21 at 19:13 -0700, Andrew Morton wrote:

<snip> (I'll let those more familiar with the memory controller efforts
comment on those concerns)

> (btw, using the term "class" to identify a group of tasks isn't very
> comfortable - it's an instance, not a class...)

Yes, I can see how this would be uncomfortable. How about replacing
"class" with "resource group"?

Cheers,
	-Matt Helsley

