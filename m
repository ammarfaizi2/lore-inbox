Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312405AbSDCWJ7>; Wed, 3 Apr 2002 17:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312402AbSDCWJt>; Wed, 3 Apr 2002 17:09:49 -0500
Received: from mail.webmaster.com ([216.152.64.131]:63687 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S312366AbSDCWJa> convert rfc822-to-8bit; Wed, 3 Apr 2002 17:09:30 -0500
From: David Schwartz <davids@webmaster.com>
To: <alan@lxorguk.ukuu.org.uk>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.61 (1025) - Licensed Version
Date: Wed, 3 Apr 2002 14:09:26 -0800
In-Reply-To: <E16ssNa-0004ZV-00@the-village.bc.nu>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20020403220927.AAA23416@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Apr 2002 22:33:18 +0100 (BST), Alan Cox wrote:
>>allow other people to use and modify it. You can't have it both ways --
>>there's no such thing as 'GPL but with a few extra restrictions I've added
>>to
>>the code that everyone's contributed to'.

>Nor is there "GPL with a few things ignored".

	Show me where the GPL says that you can prevent people from changing the 
code to make it more useful to them. Show me where the GPL allows you to 
build 'proprietary/unmodifiable' bits in to 'secure' your program against the 
types of usage you don't like.

	The GPL says, for example, "  For example, if you distribute copies of such 
a program, whether gratis or for a fee, you must give the recipients all the 
rights that you have.  You must make sure that they, too, receive or can get 
the source code.  And you must show them these terms so they know their
rights."

	The GPL explicitly grants the right to modify in section 2. It says nothing 
about not being allowed to remove 'security' or 'lockout' features. In fact, 
it would be horrible if people could put any security or lockout features 
into GPLed code.

	The GPL says, "Each time you redistribute the Program (or any work based on  
the Program), the recipient automatically receives a license from the 
original licensor to copy, distribute or modify the Program subject to
these terms and conditions.  You may not impose any further restrictions on 
the recipients' exercise of the rights granted herein. You are not  
responsible for enforcing compliance by third parties to this License."

	What could be clearer? "It's GPL but you can't change it to do things the 
original author specifically didn't want you to be able to do" is horseshit.

	DS


