Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267578AbRGSOx6>; Thu, 19 Jul 2001 10:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267579AbRGSOxt>; Thu, 19 Jul 2001 10:53:49 -0400
Received: from [207.198.61.36] ([207.198.61.36]:36480 "EHLO
	va.flyingbuttmonkeys.com") by vger.kernel.org with ESMTP
	id <S267578AbRGSOxe>; Thu, 19 Jul 2001 10:53:34 -0400
Message-ID: <007a01c11062$799a0160$c2d487d1@cartman>
From: "Michael Rothwell" <rothwell@flyingbuttmonkeys.com>
To: "Edouard Soriano" <e_soriano@dapsys.com>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20010719.14393700@dap21.dapsys.ch>
Subject: Re: 1GB system working with 64MB
Date: Thu, 19 Jul 2001 10:52:43 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Add this:

append="mem=1024M"

to your lilo boot profiles.

... 2.4 correctly detects memory size more often than 2.2.16 ...


----- Original Message ----- 
From: "Edouard Soriano" <e_soriano@dapsys.com>
Subject: 1GB system working with 64MB


> Hello Folks,
> Environment: linux 2.2.16smp
> RedHat 7.0
>
> My problem are the 63892K


