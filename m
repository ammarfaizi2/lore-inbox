Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVCSM16@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVCSM16 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 07:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCSM16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 07:27:58 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:40077 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261381AbVCSM1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 07:27:54 -0500
Date: Sat, 19 Mar 2005 13:27:49 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: 3c59x concerns on 2.4->2.6 update?
Message-ID: <20050319122749.GB13652@merlin.emma.line.org>
Mail-Followup-To: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20050318103418.GA14636@merlin.emma.line.org> <20050319102250.GA11557@bayes.mathematik.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050319102250.GA11557@bayes.mathematik.tu-chemnitz.de>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steffen Klassert schrieb am 2005-03-19:

> In 2.6.11 ethtool data should be available. Please let me know if
> you are using 2.6.11 and ethtool does not work with your card. 
> 
> I have no Tornado card to test but with 3c905/3c905B cards and 
> options=0x204 configured, mii-diag reports:
> Auto-negotiation disabled, with Speed fixed at 100 mbps, full-duplex.
> 
> I suppose you talking about 3c905C Tornado cards 
> (3c900 cards are not of Tornado type).

Ouch. Yes indeed, 3C905C. Please excuse my spreading confusion here.
(I also have 3C900 Combo here, these are Boomerang cards.)

I'll try 2.6.11 as workload permits, the machine is a router in
production with SuSE 9.2 (2.6.8 + SuSE hacks, "2.6.8-24.11-default")
kernel.

-- 
Matthias Andree
