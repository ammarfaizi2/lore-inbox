Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312208AbSC2Vwr>; Fri, 29 Mar 2002 16:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312194AbSC2Vwi>; Fri, 29 Mar 2002 16:52:38 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:2574 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S312169AbSC2VwV>; Fri, 29 Mar 2002 16:52:21 -0500
Subject: Re: Request for 2.4.20 to be a non-trivial-bugfixes-only
To: Ruth.Ivimey-Cook@ivimey.org (Ruth Ivimey-Cook)
Date: Fri, 29 Mar 2002 22:08:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <5.1.0.14.0.20020329210032.00b82b38@mailhost.ivimey.org> from "Ruth Ivimey-Cook" at Mar 29, 2002 09:32:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16r4Y5-00023F-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please note I didn't say .20 *and all future versions*. I asked because it 
> just seems to me that while kernel 2.4 is definitely improving, it is being 
> pulled hard in 2 directions -- towards stability and towards 2.5.

In a lot of cases like the USB stuff they are both the same thing. The
stuff filtering back is bug fixes found in the development tree and tested
by the lunatic fringe. The 2.4 -ac tree doesn't quite obey the rules but
the fun stuff like the O(1) scheduler code is stuff I don't intend to
push to Marcelo. 

> I was hoping that, if we had a release that was focused on stability, the 
> current code base might get a longer testing phase, resulting in a better 
> code base overall.

That release is 2.4.* (or should be)

Alan

