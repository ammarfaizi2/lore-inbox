Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278673AbRKOFKd>; Thu, 15 Nov 2001 00:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278800AbRKOFKX>; Thu, 15 Nov 2001 00:10:23 -0500
Received: from symphony-01.iinet.net.au ([203.59.3.33]:33553 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id <S278673AbRKOFKO>;
	Thu, 15 Nov 2001 00:10:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Adam Harvey <matlhdam@iinet.net.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.14 fails to boot on a MediaGX
Date: Thu, 15 Nov 2001 13:11:56 +0800
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E163y2Z-0004OH-00@the-village.bc.nu>
In-Reply-To: <E163y2Z-0004OH-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01111513115600.00812@blackbox.local>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2001 19:17, Alan Cox wrote:
> Ok on my box it boots fine. As an experiment can you build a kerne with no
> PCI support (Im not saying it'll be useful production wise but it will tell
> me if its a PCI issue)

And, interestingly enough, it does boot with PCI switched off.

Given that it's a somewhat unusual motherboard, I'm pretty willing to just 
put an ISA network card in there and write it off as flaky hardware, but it's 
odd that it boots under 2.2 with PCI support on.

Adam
