Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVJSUpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVJSUpp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVJSUpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:45:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21428 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750751AbVJSUpo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:45:44 -0400
Date: Wed, 19 Oct 2005 13:45:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ravikiran G Thirumalai <kiran@scalex86.org>
cc: Yasunori Goto <y-goto@jp.fujitsu.com>,
       Alex Williamson <alex.williamson@hp.com>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, tglx@linutronix.de, shai@scalex86.org
Subject: Re: [discuss] Re: x86_64: 2.6.14-rc4 swiotlb broken
In-Reply-To: <20051019180702.GA3680@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0510191343590.3369@g5.osdl.org>
References: <20051018232203.GB4535@localhost.localdomain>
 <1129684966.17545.50.camel@lts1.fc.hp.com> <20051019212041.6378.Y-GOTO@jp.fujitsu.com>
 <20051019180702.GA3680@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 19 Oct 2005, Ravikiran G Thirumalai wrote:
> 
> Linus would you apply this for 2.6.14?  This is the patch which works for
> both x86_64 and ia64 boxes.

Ok, I'd love to have something that people finally agree on.

Can you re-post the final version as such, with explanations for the 
commit messages and the sign-off, and people who have issues with it 
_please_ speak up asap?

			Linus
