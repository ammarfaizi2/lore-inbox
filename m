Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbUCRAZA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 19:25:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUCRAZA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 19:25:00 -0500
Received: from [130.57.169.10] ([130.57.169.10]:24286 "EHLO peabody.ximian.com")
	by vger.kernel.org with ESMTP id S262227AbUCRAY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 19:24:57 -0500
Subject: Re: status of PREEMPT and SMP together?
From: Robert Love <rml@ximian.com>
To: Anton Blanchard <anton@samba.org>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>,
       Linux kernel <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <20040317233657.GD28212@krispykreme>
References: <4058C37F.8070409@nortelnetworks.com>
	 <1079560828.1435.24.camel@localhost>  <20040317233657.GD28212@krispykreme>
Content-Type: text/plain
Message-Id: <1079569475.1898.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-1) 
Date: Wed, 17 Mar 2004 19:24:35 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 18:36, Anton Blanchard wrote:

> Sorry, I had planned to send it once Linus got over his deep freeze mode
> but forgot. Here it is.

Thanks.

> Now that the option is selectable I marked it BROKEN for the moment
> since we havent got around to doing the low level exception bits yet...
> Do you have a G5 yet? :)

Unfortunately, no. ;-)

I think the low-level bits are there for PPC32, right?  So just PPC64 is
missing the kernel entry/exit and interrupt changes?

	Robert Love




