Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbUBJExy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265626AbUBJExy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:53:54 -0500
Received: from shiva.warpcore.org ([216.81.249.60]:9439 "EHLO
	shiva.warpcore.org") by vger.kernel.org with ESMTP id S265603AbUBJExw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:53:52 -0500
Subject: Kernel GPL Violations and How to Research
From: Gidon <gidon@warpcore.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1076388828.9259.32.camel@CPE-65-26-89-23.kc.rr.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 09 Feb 2004 22:53:50 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am unsure as to where to begin with this, but I have found a project
that I believe contains Linux kernel code and is not honouring the
requirements of the GPL. I will not disclose the name of the project to
anyone but the main Kernel developers or legal counsel because I do not
want thousands of angry emails disparaging the project in question. My
goal in this matter is to identify and make as certain as possible that:

1) A violation actually exists

2) To see the matter resolved through education regarding the terms of
the license of the Linux kernel code

3) To have any code if it is indeed violating the GPL license to be
replaced or removed

4) Failing number three, to see the Kernel's license honoured and if not
ensuring that the proper people have enough information to move forward
with any necessary steps to see that it is

I have already contacted the legal counsel for the FSF for advice as
well as the previous maintainer of the file / code in question that I
believe has been misappropriated. Both suggested I further research the
issue in detail and that my initial findings "looked bad" for the
project in question. However, during further research it has come to
attention that it is rather difficult to confirm whether or not a
particular program is using GPL'd code.

So what I am writing to ask, is what is the best way to ascertain
whether or not a binary (in this case a "kernel image" of this project)
contains GPL'd code or functions. So far I have found nearly a hundred
identical (down to formatting specifiers, punctuation, etc.) or nearly
identical error messages that consistently match areas of Linux i386
arch specific kernel code or drivers as well as matching function names,
using the "strings" program on their Kernel image.

It is my belief (and hope) at this point that the project in question is
violating the GPL, but out of ignorance rather than intentional
disregard for the license of Linux kernel code.

Any assistance from a Kernel maintainer or other qualified individual
that is willing to help me discreetly in this matter would be greatly
appreciated.

Thanks,
-- 
I am subscribed to this mailing list. It is not necessary to CC me.
Thank you. -Gidon

