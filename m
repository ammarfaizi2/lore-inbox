Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750964AbWF3LBY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750964AbWF3LBY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 07:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750904AbWF3LBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 07:01:24 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:19922 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750803AbWF3LBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 07:01:23 -0400
Date: Fri, 30 Jun 2006 13:01:21 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Dave Jones <davej@redhat.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.17-mm4
Message-ID: <20060630110121.GA26844@rhlx01.fht-esslingen.de>
References: <20060629013643.4b47e8bd.akpm@osdl.org> <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com> <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu> <20060629230517.GA18838@elte.hu> <1151662073.31392.4.camel@localhost.localdomain> <1151661242.11434.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1151661242.11434.20.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 30, 2006 at 11:54:02AM +0200, Arjan van de Ven wrote:
> On Fri, 2006-06-30 at 11:07 +0100, Alan Cox wrote:
> > Not especially. Perhaps the best thing to do here would be to make qdi
> > compiled into the kernel (as opposed to modular) only do so if
> > "probe_qdi=1" or similar is set.
> 
> another quick hack is to check for vesa lb... eg if pci is present, skip
> this thing entirely :)

Eh? You haven't really heard of those quite popular ISA/VLB/PCI 486 combo
boards, now have you? ;)
(IIRC I had one of those things a looooong time ago)

Andreas Mohr
