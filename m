Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263606AbREYHhZ>; Fri, 25 May 2001 03:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263609AbREYHhP>; Fri, 25 May 2001 03:37:15 -0400
Received: from pc1-camb6-0-cust57.cam.cable.ntl.com ([62.253.135.57]:64934
	"EHLO kings-cross.london.uk.eu.org") by vger.kernel.org with ESMTP
	id <S263606AbREYHhI>; Fri, 25 May 2001 03:37:08 -0400
X-Mailer: exmh version 2.3.1 01/18/2001 (debian 2.3.1-1) with nmh-1.0.4+dev
To: "Eric S. Raymond" <esr@thyrsus.com>, CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Configure.help entries wanted 
In-Reply-To: Message from "Eric S. Raymond" <esr@thyrsus.com> 
   of "Fri, 25 May 2001 01:22:00 EDT." <20010525012200.A5259@thyrsus.com> 
In-Reply-To: <20010525012200.A5259@thyrsus.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 25 May 2001 08:36:52 +0100
From: Philip Blundell <philb@gnu.org>
Message-Id: <E153C9U-0001op-00@kings-cross.london.uk.eu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>CONFIG_ARCH_FTVPCI
>CONFIG_ARCH_NEXUSPCI

These symbols both refer to the same thing (the latter is an obsolete name).
I guess appropriate text would be something like:

  Say Y here if you intend to run this kernel on a FutureTV (nee Nexus 
  Electronics) StrongARM PCI card.

p.


