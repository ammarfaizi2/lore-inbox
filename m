Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312323AbSDEGHA>; Fri, 5 Apr 2002 01:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312322AbSDEGGl>; Fri, 5 Apr 2002 01:06:41 -0500
Received: from mail.webmaster.com ([216.152.64.131]:12504 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S312321AbSDEGGb> convert rfc822-to-8bit; Fri, 5 Apr 2002 01:06:31 -0500
From: David Schwartz <davids@webmaster.com>
To: <alan@lxorguk.ukuu.org.uk>, Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Thu, 4 Apr 2002 22:06:28 -0800
In-Reply-To: <E16sqXF-0004Li-00@the-village.bc.nu>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020405060629.AAA7397@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Actually it does. EXPORT_SYMBOL_GPL is a digital rights management system
>subverting it is a US offence. Now if anyone was to go cart Andrea off to
>jail for that I'd be pretty pissed off. Its stupidity factor is stunningly
>high but it doesn't change the reality. Nor for that matter should anyone
>forget that stupid laws can be used for good as well as evil some times 8)

	Do you really want to argue that someone can add a digital rights management 
system into a GPL'd product, distribute it, and nobody else can modify that 
digital rights management system?

	This would mean that I could take the Linux kernel, make some changes to it, 
and distribute it. I could add a digital rights management system that made 
it impossible to use any of my changed code if you changed anything else at 
all, or better yet, you couldn't use it unless you had a hardware dongle.

	Is it your position that this would be okay with the GPL? That I could 
effectively steal the hard work of all those Linux developers by using their 
code in a proprietary product against their wishes as clearly expressed in 
the GPL?

	You're out of your mind on this one. The GPL gives you the right to modify 
GPL'd code. And if you distribute it, you must also distribute the source so 
that anyone else can modify it. You cannot contribute to GPL'd code, 
distribute it, and restrict its use. That is *precisely* what the GPL was 
supposed to prevent.

	DS


