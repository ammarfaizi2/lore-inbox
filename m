Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292898AbSB0VTc>; Wed, 27 Feb 2002 16:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292841AbSB0VS4>; Wed, 27 Feb 2002 16:18:56 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:62999 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id <S292958AbSB0VSZ>; Wed, 27 Feb 2002 16:18:25 -0500
Date: Wed, 27 Feb 2002 22:17:01 +0100
Message-Id: <200202272117.g1RLH1Vm004129@lt.wsisiz.edu.pl>
From: Lukasz Trabinski <lukasz@lt.wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.4.18 and RH 7.2
In-Reply-To: <20020227202622.A25404@flint.arm.linux.org.uk>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.12-20020203 ("Toxicity") (UNIX) (Linux/2.4.19pre1 (i586))
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20020227202622.A25404@flint.arm.linux.org.uk> you wrote:

> iptables 1.2.4 was rebuild for the 2.4.17 because it stopped working at
> that point.  I hope it isn't requirement to rebuild iptables against each
> stable kernel release.

Please try  1.2.6 snapshot or try rebuild it with -DNODEBUG make flag.
RPMS/SRPM available at ftp://ftp.wsisiz.edu.pl/pub/Linux/rpms-7x

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
