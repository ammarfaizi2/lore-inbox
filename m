Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268060AbUJSJA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268060AbUJSJA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 05:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJSJA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 05:00:26 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:3771 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268060AbUJSJAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 05:00:24 -0400
Date: Tue, 19 Oct 2004 11:00:19 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Matthias Andree <matthias.andree@gmx.de>,
       Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 BK build broken
Message-ID: <20041019090019.GA6020@merlin.emma.line.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20041019021719.GA22924@merlin.emma.line.org> <41747CA6.7030400@pobox.com> <41748ADE.70403@pobox.com> <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410182208020.2287@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004, Linus Torvalds wrote:

> > > I get an ICE here in -BK-latest, which the attached patch fixes (backs 
> > > out Linus's change).
> 
> Heh. Clearly there's a gcc bug.. What compiler version?
> 
> I've got gcc-3.2 and gcc-3.3, and neither seems to have any trouble, but 
> hey, I'm cursed by having fairly up-to-date systems.

Linus,

I'd tried SuSE's gcc-3.3.3-41 (as shipped with SuSE Linux 9.1 Pro),
pristine gcc 3.3.4, pristine gcc 3.4.2, each of the three failed - and I
therefore claim "having really up-to-date compilers" for my system.

-- 
Matthias Andree
