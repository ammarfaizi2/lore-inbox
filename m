Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261692AbTDBGgX>; Wed, 2 Apr 2003 01:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261711AbTDBGgX>; Wed, 2 Apr 2003 01:36:23 -0500
Received: from amsfep11-int.chello.nl ([213.46.243.20]:60737 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id <S261692AbTDBGgV>; Wed, 2 Apr 2003 01:36:21 -0500
From: Jos Hulzink <josh@stack.nl>
To: Matthew Harrell 
	<mharrell-dated-1049671247.27e955@bittwiddlers.com>
Subject: Re: [Bug 529] New: ACPI under 2.5.50+ (approx) locks system hard during bootup
Date: Wed, 2 Apr 2003 08:47:34 +0200
User-Agent: KMail/1.5
Cc: linux-kernel <linux-kernel@vger.kernel.org>
References: <130680000.1049224849@flay> <200304020107.58676.josh@stack.nl> <20030401232043.GA10066@bittwiddlers.com>
In-Reply-To: <20030401232043.GA10066@bittwiddlers.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304020847.34735.josh@stack.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 April 2003 01:20, Matthew Harrell wrote:
> I sympathize since I've been feeling the same way.  When I mentioned it to
> Andrew in response to another ACPI problem I saw posted he recommended I
> send it via bugzilla to see if more people will pay attention then.
>
> But, in the ACPI team's defense, I also have about three other computers
> with ACPI that do work fine and I've seen a number of other people on the
> ACPI list without problems.  In my case it's annoying since it's my laptop
> which has the problem and that's the only one that I really care about when
> it comes to ACPI.
>
> I suggest you read through my initial email and see if you find anything
> unusually different in your setup.  I'm not positive since I'm new to
> bugzilla but if you do have anything different that you notice then go to
> bugzilla.kernel.org under bug 529 and add on to the bug report.  Sounds
> like the more info the better for this bug

I sure will. My plain Asus P2L97-DS with plain PII 333 SMP, plain Intel 440 
LX, plain Soundblaster Live, plain 3Com 3C905C and plain Matrox G400 has no 
trouble at all with 2.4 kernels, all IRQ lines claimed succesfully. With 
recent 2.5 kernels it is simply: IDW ! No fancy strange laptop, no "made in 
antarctica" chipset, only a SMP configuration on one of the most used 
chipsets in the world, and yes, I enabled MPS 1.4 support for I had trouble 
with shared IRQs. (FWIW: MPS 1.4 also reroutes interrupts)

Jos
