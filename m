Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262054AbVC1Tuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262054AbVC1Tuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVC1Tuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 14:50:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:50582 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262054AbVC1TuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 14:50:25 -0500
Subject: Re: Industry db benchmark result on recent 2.6 kernels
From: Dave Hansen <haveblue@us.ibm.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: "'Andrew Morton'" <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200503281933.j2SJXJg22526@unix-os.sc.intel.com>
References: <200503281933.j2SJXJg22526@unix-os.sc.intel.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 11:50:16 -0800
Message-Id: <1112039416.2087.25.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 11:33 -0800, Chen, Kenneth W wrote:
> We will be taking db benchmark measurements more frequently from now on with
> latest kernel from kernel.org (and make these measurements on a fixed interval).
> By doing this, I hope to achieve two things: one is to track base kernel
> performance on a regular base; secondly, which is more important in my opinion,
> is to create a better communication flow to the kernel developers and to keep
> all interested party well informed on the kernel performance for this enterprise
> workload.

I'd guess that doing it on kernel.org is too late, sometimes.  How high
is the overhead of doing a test?  Would you be able to test each -mm
release?  It's somewhat easier to toss something out of -mm for
re-review than it is out of Linus's tree.

-- Dave

