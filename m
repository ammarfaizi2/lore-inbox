Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261567AbTCOWLu>; Sat, 15 Mar 2003 17:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261584AbTCOWLu>; Sat, 15 Mar 2003 17:11:50 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:39051 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S261567AbTCOWLt>; Sat, 15 Mar 2003 17:11:49 -0500
From: Alan Cox <alan@redhat.com>
Message-Id: <200303152222.h2FMMbb20136@devserv.devel.redhat.com>
Subject: Re: [PATCH][kconfig][i386] Fix help entry for processor type choice
To: pasky@ucw.cz (Petr Baudis)
Date: Sat, 15 Mar 2003 17:22:37 -0500 (EST)
Cc: davej@codemonkey.org.uk (Dave Jones), alan@redhat.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030315214558.GE31875@pasky.ji.cz> from "Petr Baudis" at Mar 15, 2003 10:45:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	  Select this for a 386 series processor, that is AMD/Cyrix/Intel
> +	  386DX/DXL/SL/SLC/SX, Cyrix/TI 486DLC/DLC2, UMC 486SX-S and NexGen
> +	  Nx586. Kernel compiled for this processor will also run on any newer
> +	  processor of this architecture, although not optimally fast.

There are about ten other processors. Trying to list them all is going
to send people potty. Also some UMC don't work with this or any other
option. 

The list you have now looks pretty sensible as a basis.

