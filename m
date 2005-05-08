Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262889AbVEHQHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262889AbVEHQHU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 12:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbVEHQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 12:07:20 -0400
Received: from mail.nagafix.co.uk ([213.228.237.37]:61604 "EHLO
	mail.nagafix.co.uk") by vger.kernel.org with ESMTP id S262889AbVEHQHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 12:07:17 -0400
Subject: Re: 2.6.11.8 + UML/x86_64 (2.6.12-rc3+) = oops
From: Antoine Martin <antoine@nagafix.co.uk>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org, jdike@addtoit.com
In-Reply-To: <m1acn5vjdz.fsf@muc.de>
References: <20050504191828.620C812EE7@sc8-sf-spam2.sourceforge.net>
	 <1115248927.12088.52.camel@cobra> <1115392141.12197.3.camel@cobra>
	 <1115483506.12131.33.camel@cobra> <m1ekchvmb0.fsf@muc.de>
	 <1115570102.10373.23.camel@cobra>  <m1acn5vjdz.fsf@muc.de>
Content-Type: text/plain
Date: Sun, 08 May 2005 18:38:58 +0100
Message-Id: <1115573938.10373.46.camel@cobra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4-3mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, the bug is found now. It is a kernel bug that it allows to set
> non canonical addresses in 64bit segment registers through ptrace.
Is this going to be part of 2.6.11.9 or just 2.6.12?
I've got a good test environment now if you need testers.

Antoine

