Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbULaLD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbULaLD4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 06:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbULaLDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 06:03:55 -0500
Received: from smtp.MYNET.JP ([43.244.0.72]:63499 "EHLO SMTP.MyNET.JP")
	by vger.kernel.org with ESMTP id S261850AbULaLDw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 06:03:52 -0500
Message-ID: <20041231200350.eme@v003.vaio.ne.jp>
Date: Fri, 31 Dec 2004 20:03:50 +0900
From: eme@v003.vaio.ne.jp
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: QUESTION: What's the difference between MCYRIXIII and MVIAC3_2
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
X-Client-IP: 218.221.50.205
X-Originating-Email: eme@v003.vaio.ne.jp
X-Mailer: UbiqMail Ver 3.0.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have a question to ask.
When compiling the kernel, there's a option to select
the Processor type and features.

In kernel 2.6.7, I see two options for C3 Processors.
I could see that MCYRIXIII is for C3 processors that's not Nehemiah core.
And MVIAC3_2 is for C3 processors that is Nehemiah core.

In the help it says that MCYRIXIII kernel doesn't work with
Nehemiah core, and MVIAC3_2 kernel doesn't work with C3 processor,
not Nehemiah core.
But my PC(Nehemiah core) has been working fine with MCYRIXIII,
which in the help says, it's not gonna work with Nehemiah.
I compiled another kernel with MVIAC3_2, which also works fine.
Now I'm thinking that there must not be major difference between
two, but is there?

If there's someone that knows the difference, please tell me.

# I found out that MVIAC3_2 uses CMOV function, where MCYRIXIII
# doesn't.But I really dont know what kind of problem that CMOV
# brings...

Thanks in advance.

===============================
Hideaki Nemoto
E-mail: eme@v003.vaio.ne.jp

Thanks all, for your kind help
===============================

