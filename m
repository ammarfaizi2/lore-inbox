Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263552AbTIBFkq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 01:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263553AbTIBFkp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 01:40:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:9866 "EHLO mail.jlokier.co.uk")
	by vger.kernel.org with ESMTP id S263552AbTIBFkn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 01:40:43 -0400
Date: Tue, 2 Sep 2003 06:40:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org
Subject: Re: x86, ARM, PARISC, PPC, MIPS and Sparc folks please run this
Message-ID: <20030902054008.GB7619@mail.jlokier.co.uk>
References: <20030829053510.GA12663@mail.jlokier.co.uk> <20030829103943.A18608@home.com> <20030901060040.GH748@mail.jlokier.co.uk> <52oey4ifut.fsf@topspin.com> <20030901191647.A8701@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030901191647.A8701@home.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Porter wrote:
> Exactly.  After reading some other subthreads I see the other version of
> "cache coherency" that Jamie is interested in.

Indeed, quite a lot of systems don't offer cache coherence with
peripherals, other CPUs (if any) and in some cases even with other
tasks on the same CPU.  Isn't memory fun? :)

-- Jamie
