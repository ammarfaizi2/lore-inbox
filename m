Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbVIVI5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbVIVI5U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 04:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751458AbVIVI5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 04:57:20 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:6066 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751457AbVIVI5T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 04:57:19 -0400
Date: Thu, 22 Sep 2005 10:57:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Zachary Amsden <zach@vmware.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Jeffrey Sheldon <jeffshel@vmware.com>,
       Ole Agesen <agesen@vmware.com>, Shai Fultheim <shai@scalex86.org>,
       Andrew Morton <akpm@odsl.org>, Jack Lo <jlo@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Chris Wright <chrisw@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH 2/3] Gdt_accessor
Message-ID: <20050922085752.GB25909@elte.hu>
References: <200509220748.j8M7mL7r000993@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509220748.j8M7mL7r000993@zach-dev.vmware.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Zachary Amsden <zach@vmware.com> wrote:

> Add an accessor function for getting the per-CPU gdt.  Callee must 
> already have the CPU.
> 
> Signed-off-by: Zachary Amsden <zach@vmware.com>

Acked-by: Ingo Molnar <mingo@elte.hu>

	Ingo
