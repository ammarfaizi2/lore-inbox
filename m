Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263793AbREYQUx>; Fri, 25 May 2001 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263792AbREYQUn>; Fri, 25 May 2001 12:20:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48655 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263793AbREYQUi>; Fri, 25 May 2001 12:20:38 -0400
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
To: aaronl@vitelus.com (Aaron Lehmann)
Date: Fri, 25 May 2001 17:17:44 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010524213404.A22585@vitelus.com> from "Aaron Lehmann" at May 24, 2001 09:34:04 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E153KHY-0006kh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which is why I asked for RMS' opinion. He said that what is being done
> is clearly not "mere aggregation", and that such firmware should be
> moved out of the kernel (and even the tarball) to stop violating the
> GPL and make Linux be free software.

Given that the firmware is a seperate work (try loading it under windows
and you'll find its quite useful without Linux and does not depend on Linux)
and that the folks I have raised this with - who should know their law - 
disagree with Adam I'm not currently persuaded.

The relationship between a USB driver and the kernel is no different to that
between say a web browser and server chatting over a network. In this case
the network is USB not IP based that is all. Clearly mozilla does not cease
to be free software or a seperate work because you looked at microsoft.com
with it.

Now if you want a plausible example of the kind of thing Adam is talking about
you should take a hard look at the ACPI code, where ACPI bytecode is linked
into the kernel by interpreting it

Alan

