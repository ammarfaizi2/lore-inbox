Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262804AbUJ1H22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262804AbUJ1H22 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbUJ1H21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:28:27 -0400
Received: from hacksaw.org ([66.92.70.107]:41667 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S262804AbUJ1H2Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:28:24 -0400
Message-Id: <200410280728.i9S7SIYW017628@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: Re: My thoughts on the "new development model" 
In-reply-to: Your message of "28 Oct 2004 16:46:58 +1000."
             <m1sm7znxul.fsf@mo.optusnet.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 28 Oct 2004 03:28:18 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That's NOT the same as bug free software. For a start, there's no such
> thing.

Speaking of which, here's something I have wondered: is anyone out there 
trying to prove the correctness of core functions in the kernel? I was 
thinking this would be a fine activity for all those eager college students 
out there, or perhaps a graduate student project, a la the Stanford Checker 
project.

While I can't imagine the main developers doing such a thing, I think it'd be 
useful and might uncover some hard to find bugs.

I'd also suspect that they might be good candidates for proving, as there's 
not so much reason to have side effect riddled code, as one might for GUI 
programs.

-- 
A psychosis is a psychosis, but a Manwich is a meal
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


