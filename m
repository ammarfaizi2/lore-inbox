Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132692AbRDOQOx>; Sun, 15 Apr 2001 12:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132693AbRDOQOn>; Sun, 15 Apr 2001 12:14:43 -0400
Received: from mail1.rdc2.ab.home.com ([24.64.2.48]:32177 "EHLO
	mail1.rdc2.ab.home.com") by vger.kernel.org with ESMTP
	id <S132692AbRDOQOb>; Sun, 15 Apr 2001 12:14:31 -0400
Message-ID: <3ADAC95A.6B35B8DE@home.com>
Date: Mon, 16 Apr 2001 04:28:42 -0600
From: "Matthew W. Lowe" <swds.mlowe@home.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: RE: 2.4.3 - Module problems?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey, Thanks for all the help everyone. So far this is my exact
configuration:
Two NICs, 3COM Etherlink III ISA, Realtek 8029 PCI (Covered by the
NE2000 PCI module). Both cards are setup for PnP, the modules have been
built into the kernel. (It worked in my old version with them build into
the kernel.)

I have upgraded to the latest modutils, and it appeared to fix the
problem with the 3COM Etherlink III card.

Alan Cox:
You mentioned turning PnP off if I was building the modules into the
kernel? Is there something in the later versions of the kernel that is
setup like that, or ?? (** didn't quite understand what you meant **)

Thanks,
   Matt


