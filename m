Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311870AbSCOAHn>; Thu, 14 Mar 2002 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311872AbSCOAHd>; Thu, 14 Mar 2002 19:07:33 -0500
Received: from mail3.iil.ie ([217.78.0.24]:56847 "HELO
	mail3.internet-ireland.ie") by vger.kernel.org with SMTP
	id <S311870AbSCOAHT>; Thu, 14 Mar 2002 19:07:19 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Golden <david.golden@oceanfree.net>
Organization: Legion
To: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
Date: Fri, 15 Mar 2002 00:12:42 +0000
X-Mailer: KMail [version 1.2]
In-Reply-To: <E16le8P-00028c-00@the-village.bc.nu>
In-Reply-To: <E16le8P-00028c-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <02031500124202.02088@golden1.goldens.ie>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 March 2002 22:55, Alan Cox wrote:
>
> We've got one. Its 0x80. It works everywhere with only marginal non
> problematic side effects

I've always liked POST cards.  They could hypothetically be useful
for kernel development,too  - who hasn't wanted a low-level 
single-asm-instruction status output from a running system at one time or 
another , independent of any other output mechanisms?

OK it's a single byte, but it's still nice...  That's two whole hex digits!
DE... AD...  BE... EF... !
