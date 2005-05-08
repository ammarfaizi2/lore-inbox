Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVEHRfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVEHRfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 13:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbVEHRfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 13:35:24 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:4872 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262905AbVEHRfV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 13:35:21 -0400
Date: Sun, 8 May 2005 12:38:53 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Andi Kleen <ak@muc.de>
Cc: Antoine Martin <antoine@nagafix.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
Message-ID: <20050508163853.GB25130@ccure.user-mode-linux.org>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net> <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra> <1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1ekchvmb0.fsf@muc.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you sure you did not apply any strange UML related patches
> to the host kernel? Maybe those are buggy.

No, stock x86_64 kernel is horribly unstable running UML.  I haven't seen
anything but output-free hangs, so I haven't had much information to 
contribute.  Antoine is actually getting capturable oopses.

I've tried every recent FC3 kernel, plus stock 2.6.10, and none of them
survive very long with UML running.  Haven't tried stock 2.6.11 or anything
later yet.

				Jeff
