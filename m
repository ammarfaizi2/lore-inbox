Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbTJ2XOV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 18:14:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJ2XOV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 18:14:21 -0500
Received: from cpc1-cwma1-5-0-cust4.swan.cable.ntl.com ([80.5.120.4]:44998
	"EHLO dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262066AbTJ2XOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 18:14:20 -0500
Subject: Re: SiS ISA bridge IRQ routing on 2.6 ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Nick Piggin <piggin@cyberone.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0310291124230.973@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.56.0310281931510.933@bigblue.dev.mdolabs.com>
	 <3F9F4841.2040904@cyberone.com.au>
	 <Pine.LNX.4.56.0310291124230.973@bigblue.dev.mdolabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1067469078.10526.12.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-4) 
Date: Wed, 29 Oct 2003 23:11:19 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-10-29 at 19:27, Davide Libenzi wrote:
> Alan did not like my approach, so I'll let him post to Linus his work. If

I generalised it to remove a ton of nasty 440GX hacks and also make the
code smaller by swapping a big table for little __init functions. I sent
akpm comments on it but I never did a 2.6 version directly. Its the same
code in both cases however.

Right now I have exams, which is why I'm reading email not revising ;)

