Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUAHBwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 20:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263166AbUAHBwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 20:52:42 -0500
Received: from dp.samba.org ([66.70.73.150]:32929 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263101AbUAHBwl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 20:52:41 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Bryan Rittmeyer <bryanrNO@SPAMcaltech.edu>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6][TRIVIAL][SPELLING] OTHO->OTOH 
In-reply-to: Your message of "Wed, 07 Jan 2004 01:49:58 -0800."
             <20040107094957.GA12409@clyde.caltech.edu> 
Date: Thu, 08 Jan 2004 12:46:23 +1100
Message-Id: <20040108015238.B72E62C0BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040107094957.GA12409@clyde.caltech.edu> you write:
> - * OTHO the cpuarrays can contain lots of objects,
> + * OTOH the cpuarrays can contain lots of objects,

Comes under the "too trivial" rule for the Trivial Patch Monkey.

For clarification:

1) It's not a spelling mistake in documentation, or any message a user
   will see.

2) It's not likely to cause someone to miss a grep (such as a
   misspelled function name in a comment would).

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
