Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265839AbTIKBVR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 21:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbTIKBVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 21:21:17 -0400
Received: from holomorphy.com ([66.224.33.161]:438 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265839AbTIKBVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 21:21:07 -0400
Date: Wed, 10 Sep 2003 18:22:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Patricia Gaughen <gone@us.ibm.com>,
       James Cleverdon <jamesclv@us.ibm.com>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] allow x86 NUMA architecture detection to fail
Message-ID: <20030911012200.GP4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Patricia Gaughen <gone@us.ibm.com>,
	James Cleverdon <jamesclv@us.ibm.com>, Andi Kleen <ak@muc.de>
References: <1063242888.32125.243.camel@nighthawk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063242888.32125.243.camel@nighthawk>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 06:14:48PM -0700, Dave Hansen wrote:
> BTW, this doesn't address NUMA-Q.  I think I have posession of more than
> 50% of the NUMA-Q's running Linux on the planet, and I'm too lazy to fix
> it for just myself.

I think we can let this slide until we can run with unpatched firmware
and by some catastrophe an external person running Linux on one
materializes, of which the latter is rather extremely unlikely.


-- wli
