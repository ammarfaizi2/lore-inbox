Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261478AbULNKKw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261478AbULNKKw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 05:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbULNKKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 05:10:52 -0500
Received: from lech.pse.pl ([194.92.3.7]:33690 "EHLO lech.pse.pl")
	by vger.kernel.org with ESMTP id S261478AbULNKKs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 05:10:48 -0500
Date: Tue, 14 Dec 2004 11:10:44 +0100
From: Lech Szychowski <lech.szychowski@pse.pl>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: tulip question: tulip.o vs de4x5.o
Message-ID: <20041214101044.GA8210@lech.pse.pl>
Reply-To: Lech Szychowski <lech.szychowski@pse.pl>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0411231216470.3740@p500> <20041124073628.GJ2067@lug-owl.de> <41A4DF61.8050008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A4DF61.8050008@pobox.com>
Organization: Polskie Sieci Elektroenergetyczne S.A.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >You can actually see the difference on older Alphas: de4x5 works while
> >tulip doesn't transmit or receive a single packet (getting netdev
> >watchdogs later on...).
> 
> That's a bug in tulip.

Speaking of bugs in tulip: I am still unable to use tulip driver
from 2.4.28 on my x86 SMP box (Asus P2B-DS) with Adaptec AN-6944A/TX
network card. While de4x5 works fine, with tulip at least one of the
Ethernet interfaces is unable to send/receive packets. More details
available on request.

-- 
	Leszek.

-- lech7@pse.pl 2:480/33.7          -- REAL programmers use INTEGERS --
-- speaking just for myself...
