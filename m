Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992615AbWJTUnp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992615AbWJTUnp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992692AbWJTUnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:43:45 -0400
Received: from www.osadl.org ([213.239.205.134]:12981 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S2992615AbWJTUno (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:43:44 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Andrew Morton <akpm@osdl.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061010145235.b86c7bad.akpm@osdl.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
	 <20061010120441.3cd3f8ff.akpm@osdl.org>
	 <6bffcb0e0610101444y5cf127c5y8a9e4c64640e0b8c@mail.gmail.com>
	 <20061010145235.b86c7bad.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 20 Oct 2006 22:44:35 +0200
Message-Id: <1161377075.5274.298.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 14:52 -0700, Andrew Morton wrote:
> On Tue, 10 Oct 2006 23:44:04 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
> 
> > BTW. Kernel hangs while running Cyclictest
> > (http://rt.wiki.kernel.org/index.php/Cyclictest)
> > cyclictest -t 10 -l 100000
> > (or "bin/autotest tests/cyclictest/control" in autotest). I don't see
> > nothing special on tty (currently my sysklogd is broken, FC6
> > problem..)

Michal,

is this on a SMP box ?

	tglx


