Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTHaSzG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 14:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbTHaSzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 14:55:06 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:59360 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261530AbTHaSzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 14:55:02 -0400
Date: Sun, 31 Aug 2003 20:54:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Corrin Lakeland <lakeland@lakeland.hopto.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Complete system freeze running test3, should I investiage?
Message-ID: <20030831185455.GW7038@fs.tum.de>
References: <20030828203832.GA10153@lakeland.hopto.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030828203832.GA10153@lakeland.hopto.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 08:38:32AM +1200, Corrin Lakeland wrote:

> Hi all,

Hi Corrin,

> I'm running fairly standard x86 hardware (VIA chipset, athlon, etc.)
> The system was quite stable running 2.4, but since upgrading to 2.6 
> I've had three complete system freezes.  Mouse and keyboard frozen, 
> can't ping, nothing at all in the logs.  I was hoping to submit a bug 
> report but alt-sysrq didn't work.  So, would people like me to 
> investigate further (and if so, how?) or shall I just ignore it?

this should be fixed but it's obviously hard to identify the problem.

It's unlikely it will help, but perhaps answering the following 
questions might pin it down:

What is the purpose of the machine (client, fileserver,...)?
Which Linux distribution is on the machine?
Any special/unusual software?
What was running at the time of the freezes (e.g. untar'ing a kernel 
source or watching a movie)?
What hardware (e.g. exact motherboard, graphics card,...) is in the 
computer?

> Corrin

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

