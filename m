Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263860AbTIKCga (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 22:36:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264109AbTIKCga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 22:36:30 -0400
Received: from obsidian.spiritone.com ([216.99.193.137]:38038 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263860AbTIKCg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 22:36:29 -0400
Date: Wed, 10 Sep 2003 19:35:07 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Dave Hansen <haveblue@us.ibm.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Patricia Gaughen <gone@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] allow x86 NUMA architecture detection to fail
Message-ID: <33780000.1063247706@[10.10.2.4]>
In-Reply-To: <20030911012200.GP4306@holomorphy.com>
References: <1063242888.32125.243.camel@nighthawk> <20030911012200.GP4306@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--William Lee Irwin III <wli@holomorphy.com> wrote (on Wednesday, September 10, 2003 18:22:00 -0700):

> On Wed, Sep 10, 2003 at 06:14:48PM -0700, Dave Hansen wrote:
>> BTW, this doesn't address NUMA-Q.  I think I have posession of more than
>> 50% of the NUMA-Q's running Linux on the planet, and I'm too lazy to fix
>> it for just myself.
> 
> I think we can let this slide until we can run with unpatched firmware
> and by some catastrophe an external person running Linux on one
> materializes, of which the latter is rather extremely unlikely.

Yeah, NUMA-Q doesn't matter for this - it's a static compile time option.
We need Summit dynamically to get one core kernel for the distros.

M.

