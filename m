Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310329AbSCKROv>; Mon, 11 Mar 2002 12:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310443AbSCKROg>; Mon, 11 Mar 2002 12:14:36 -0500
Received: from 99dyn73.com21.casema.net ([62.234.30.73]:22732 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S310408AbSCKROQ>; Mon, 11 Mar 2002 12:14:16 -0500
Message-Id: <200203111714.SAA01820@cave.bitwizard.nl>
Subject: Re: [Fwd: Re: Dog slow IDE]
In-Reply-To: <E16kRdg-0000pi-00@the-village.bc.nu> from Alan Cox at "Mar 11,
 2002 03:23:04 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 11 Mar 2002 18:14:06 +0100 (MET)
CC: Lionel Bouton <Lionel.Bouton@inet6.fr>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-notice1: This Email contains my Email address. This grants you the right
X-notice2: to communicate with me using this address, related to the subject
X-notice3: in this message. Unsollicitated mass-mailings are explictly 
X-notice4: forbidden here, and by Dutch law. 
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I don't know if the AMD-768 IDE is supported yet.
> > Anyone ?
> 
> It works nicely in the -ac kernel tree. Its not supported in the base
> tree.

  Bus  0, device  16, function  0:
    PCI bridge: Advanced Micro Devices [AMD] AMD-768 [??] PCI (rev 4).
      Master Capable.  No bursts.  Min Gnt=12.

Sounds like a PCI bridge, the machine works just fine. What's "not
supported" about it?

I'm still running the 2.4.16, patched with an Andre-ide-patch. 

				Roger. 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
