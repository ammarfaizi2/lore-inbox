Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318965AbSH2HHC>; Thu, 29 Aug 2002 03:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319122AbSH2HHC>; Thu, 29 Aug 2002 03:07:02 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:42192 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318965AbSH2HHB>; Thu, 29 Aug 2002 03:07:01 -0400
Date: Thu, 29 Aug 2002 09:01:43 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020829090143.B1117@brodo.de>
References: <Pine.LNX.4.33.0208281327140.8978-100000@penguin.transmeta.com> <1030577178.7190.85.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <1030577178.7190.85.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Aug 29, 2002 at 12:26:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2002 at 12:26:18AM +0100, Alan Cox wrote:
> > And I do not want to get people used to passing in frequencies, when I can 
> > absolutely _prove_ that it's the wrong thing for 99% of all uses.
> 
> 99% of people should be using something like ACPI. 

Current ACPI code does not adjust frequencies on its own, it relies on user
input too.

Dominik
