Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbTD1WbY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 18:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbTD1WbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 18:31:24 -0400
Received: from holomorphy.com ([66.224.33.161]:29384 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261365AbTD1WbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 18:31:23 -0400
Date: Mon, 28 Apr 2003 15:43:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
       Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, Riley Williams <Riley@Williams.Name>
Subject: Re: [Lse-tech] Re: maximum possible memory limit ..
Message-ID: <20030428224333.GY30441@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
	Dave Hansen <haveblue@us.ibm.com>, Andi Kleen <ak@suse.de>,
	Henti Smith <bain@tcsn.co.za>, linux-kernel@vger.kernel.org,
	lse-tech@lists.sourceforge.net,
	Riley Williams <Riley@Williams.Name>
References: <20030424200524.5030a86b.bain@tcsn.co.za> <3EAD27B2.9010807@gmx.net> <20030428141023.GC4525@Wotan.suse.de> <3EAD5AC1.7090003@us.ibm.com> <3EAD5D90.7010101@gmx.net> <3EAD61FB.30907@us.ibm.com> <3EAD6688.7060809@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EAD6688.7060809@gmx.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
>> Unless, of course, someone gets even more perverse than PAE. :)

On Mon, Apr 28, 2003 at 07:36:08PM +0200, Carl-Daniel Hailfinger wrote:
> hehe ;-) Can you say PAE in userspace?

In a sense, already done; c.f. sys_remap_file_pages().


-- wli
