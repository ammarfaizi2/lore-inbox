Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbTBGPJt>; Fri, 7 Feb 2003 10:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265532AbTBGPJt>; Fri, 7 Feb 2003 10:09:49 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:49935 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261353AbTBGPJs>; Fri, 7 Feb 2003 10:09:48 -0500
Date: Fri, 7 Feb 2003 15:19:26 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: The Linux Kernel and Castle Technology Ltd, UK
Message-ID: <20030207151926.A30927@flint.arm.linux.org.uk>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm afraid that I have to bring this news to linux-kernel; people who
have written code for the Linux kernel need to know about this, and
we need to come to a decision about the action we wish to take.  Taking
no action sends a message that "we don't care what you do with kernel
code, even if you violate the terms of the license."



It would appear that Castle Technology Limited, UK, have taken some
of the Linux kernel 2.5 code, and incorporated it into their own
product, "RISC OS", which is distributed in binary ROM form built
into machines they sell.  This code is linked with other proprietary
code.

I have a detailed description which shows how the Linux source code
can be slightly modified to produce the disputed code, with reasons
each modification.  This will be provided to people upon private
email request.

Having discussed this with Linus, Linus is of the opinion that a
public letter should be written to Castle Technology Ltd, copied to
lkml and various news sites.  However, I'd like to get this issue
into the minds of people who have touched any of the following code:

 - PCI subsystem
 - IO resource allocation

The guy who reported the problem to me has already tried to contact
the company concerned to ask for the source under the terms of the GPL,
and this resulted in the "function signatures" being removed in the
next version of the product, while the actual code remained.  No other
response was forthcoming.

Subsequently, during the first week of January, the guy has contacted
the company again asking for the source covering the disputed code,
this time copying me with the email.  Again, no repsonse from
Castle Technology has been forthcoming to date.

Thanks.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

