Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319677AbSH3Vd6>; Fri, 30 Aug 2002 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319678AbSH3Vd6>; Fri, 30 Aug 2002 17:33:58 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39691 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319677AbSH3Vd5>; Fri, 30 Aug 2002 17:33:57 -0400
Date: Fri, 30 Aug 2002 22:38:21 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Patches...
Message-ID: <20020830223821.G3555@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm about to send out 8 patches:

 --- 2.5.29-keyboard
 --- 2.5.29-pci
 --- 2.5.29-rdunzip
 --- 2.5.30-pcnet_cs
 --- 2.5.31-serport
 --- 2.5.32-bug
 --- 2.5.32-flags
 --- 2.5.32-smph

These are patches that are in the ARM tree, and I consider them to
be useful to others, bug fixes or compilation fixes that have been
collected.  All the above have been found not to be in 2.5.32.

Where applicable, they're copied to maintainers or Rusty's trivial
patch address.  However, if people want to pick off any of these
patches and integrate them into their trees, and eventually push
them towards Linus, that's fine by me.

Any that aren't picked up will be re-mailed at some point in the
future (seems like its about once every 3 weeks to a month at the
moment.)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

