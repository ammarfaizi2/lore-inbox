Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbTJJKZQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:25:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261996AbTJJKZQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:25:16 -0400
Received: from postman1.arcor-online.net ([151.189.0.187]:9978 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261982AbTJJKZO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:25:14 -0400
Date: Fri, 10 Oct 2003 12:25:10 +0200
From: Christian Fertig <fertig@informatik.uni-frankfurt.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem: 2.4.22[-ac4] Hangup with SB AWE32 (isa-pnp)
Message-ID: <20031010102510.GA2559@fufnet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <rqld51-js9.ln1@fertig-50273.user.cis.dfn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rqld51-js9.ln1@fertig-50273.user.cis.dfn.de>
X-Operating-System: Linux titan 2.4.21 
X-Fax: +49 1212 5 11393402
X-URL: http://www.fufnet.de/
X-PGP-Sig: http://www.fufnet.de/pubkey.asc
X-MSMail-Priority: Urgent Virus Delivery
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I've got a reproducable kernel hangup (no oops, no sysrq-key etc.
> anymore) with 2.4.22 and 2.4.22-ac4 on my NMC-7vax (Athlon, [Slot]).
> The sb-Modules uses a wrong Interrupt (7 instead of 5). The problem
> doesn't arise with earlier versions of the kernel. I'm using the kernel
> oss module.

Reading the ChangeLog, I don't understand why, but with 2.4.23-pre6
everything works fine.

Christian
