Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278149AbRJLV2O>; Fri, 12 Oct 2001 17:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278151AbRJLV2E>; Fri, 12 Oct 2001 17:28:04 -0400
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:14101 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S278149AbRJLV17>; Fri, 12 Oct 2001 17:27:59 -0400
Date: Fri, 12 Oct 2001 23:27:26 +0200
Message-Id: <200110122127.f9CLRQUJ002100@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: BUG - Kernel 2.4.12 doesn't compile
In-Reply-To: <000d01c15356$6c2bfec0$0100a8c0@leopoldo>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.9-20010723 ("Chord of Souls") (UNIX) (Linux/2.4.13-pre1 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <000d01c15356$6c2bfec0$0100a8c0@leopoldo> you wrote:
> I use a RH 7.1 ad trying to compile the kernel v. 2.4.12 i get the error you
> can see here:
> ieee1284_ops.c:365: (Each undeclared identifier is reported only once
> ieee1284_ops.c:365: for each function it appears in.)
> ieee1284_ops.c: In function `ecp_reverse_to_forward':
> ieee1284_ops.c:397: `IEEE1284_PH_DIR_UNKNOWN' undeclared (first use in this
> function)
> make[2]: *** [ieee1284_ops.o] Error 1

Wrong define. Try 2.4.13-pre1

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
