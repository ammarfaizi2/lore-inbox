Return-Path: <linux-kernel-owner+w=401wt.eu-S1751355AbXAMX5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751355AbXAMX5r (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751384AbXAMX5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:57:47 -0500
Received: from gate.crashing.org ([63.228.1.57]:59269 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751355AbXAMX5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:57:46 -0500
In-Reply-To: <b6a2187b0701121936t3175d7a1i21eb6fa1f72cac1d@mail.gmail.com>
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org> <20070112142645.29a7ebe3.akpm@osdl.org> <b6a2187b0701121936t3175d7a1i21eb6fa1f72cac1d@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fbd698094b9e055ebd5ea5a47288582a@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Linux v2.6.20-rc5
Date: Sun, 14 Jan 2007 00:58:14 +0100
To: "Jeff Chua" <jeff.chua.linux@gmail.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  CC [M]  drivers/kvm/vmx.o
> {standard input}: Assembler messages:
> {standard input}:3257: Error: bad register name `%sil'
> make[2]: *** [drivers/kvm/vmx.o] Error 1
> make[1]: *** [drivers/kvm] Error 2
> make: *** [drivers] Error 2
>
> Am I missing something or this is a real problem?

What's on (and sround) that line #3257?


Segher

