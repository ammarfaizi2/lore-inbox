Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288709AbSANCy4>; Sun, 13 Jan 2002 21:54:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288697AbSANCyq>; Sun, 13 Jan 2002 21:54:46 -0500
Received: from bitmover.com ([192.132.92.2]:42887 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S288703AbSANCya>;
	Sun, 13 Jan 2002 21:54:30 -0500
Date: Sun, 13 Jan 2002 18:54:28 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: ISA hardware discovery -- the elegant solution
Message-ID: <20020113185428.C8792@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <20020113205839.A4434@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020113205839.A4434@thyrsus.com>; from esr@thyrsus.com on Sun, Jan 13, 2002 at 08:58:39PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> :MTRR: your CPUs had inconsistent fixed MTRR settings
> :MTRR: probably your BIOS does not setup all CPUs
> :PCI: PCI BIOS revision 2.10 entry at 0xfd7c0, last bus=1
> :PCI: Using configuration type 1
> :PCI: Probing PCI hardware

It's ugly and distracting and if this proposal goes anywhere, move the tag to 
end of the line.  Then your eyes can scan the output and the tools can scan
the end of the line.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
