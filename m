Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbTBJReo>; Mon, 10 Feb 2003 12:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbTBJReo>; Mon, 10 Feb 2003 12:34:44 -0500
Received: from phobos.hpl.hp.com ([192.6.19.124]:11715 "EHLO phobos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261868AbTBJRen>;
	Mon, 10 Feb 2003 12:34:43 -0500
Date: Mon, 10 Feb 2003 09:36:03 -0800
To: Cory Bell <cory.bell@usa.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem w/2.5.59 & orinoco_pci (works w/2.4.18)
Message-ID: <20030210173603.GE14364@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <1044773002.3709.52.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1044773002.3709.52.camel@localhost>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2003 at 10:43:21PM -0800, Cory Bell wrote:
> This is on an old Dell Pentium/100. This may or may not be related, but
> it requires pci=conf1 (for 2.4) or pci=conf2 (for 2.5) to get proper
> lspci output. I get similar results with Jouni Malinen's hostap_pci
> driver (works in 2.4, not in 2.5), which makes me think something
> changed in 2.5 that broke both drivers. This is a Linksys WMP11 PCI
> wireless adapter.
> 
> I don't have anything fancy (himem, preempt, etc) compiled into the
> kernel, just the basics for a wireless AP/firewall.
> 
> Thanks for any help you can provide! I'm happy to supply any additional
> information or test solutions upon request. I'm not subscribed, so
> please cc me.
> 
> -Cory Bell

	This hardware never worked in my computer (tool old). I would
suggest complaining on the kernel mailing list with the details above
(and below - plus lspci -v), as it seems to point out to a generic PCI
problem, not a driver problem.

	Regards,

	Jean
