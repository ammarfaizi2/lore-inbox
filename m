Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTIJB5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 21:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264626AbTIJB5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 21:57:43 -0400
Received: from palrel10.hp.com ([156.153.255.245]:52929 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S264489AbTIJB5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 21:57:38 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16222.34064.900764.487152@napali.hpl.hp.com>
Date: Tue, 9 Sep 2003 18:57:36 -0700
To: Ian Wienand <ianw@gelato.unsw.edu.au>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: milstone reached: ia64 linux builds out of Linus' tree
In-Reply-To: <20030910005317.GE23661@cse.unsw.EDU.AU>
References: <200308041737.h74HbdCf015443@napali.hpl.hp.com>
	<16174.59114.386209.649300@wombat.chubb.wattle.id.au>
	<16174.60868.750901.704560@napali.hpl.hp.com>
	<20030813000751.GD25474@cse.unsw.edu.au>
	<20030910005317.GE23661@cse.unsw.EDU.AU>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 10 Sep 2003 10:53:17 +1000, Ian Wienand <ianw@gelato.unsw.edu.au> said:

  Ian> On Wed, Aug 13, 2003 at 10:07:51AM +1000, Ian Wienand wrote:

  >> We're still working on automated testing (i.e. booting on the
  >> simulator, maybe real hardware).

  Ian> For those who are interested, we now attempt to boot the autobuilt
  Ian> kernels on the simulator daily.  See

  Ian> http://www.gelato.unsw.edu.au/kerncomp/simboot.php

Very nice! (The test setup & web-page, not the fact that the boot
failed... ;-).

As for perfmon under Ski: the latest perfmon should have the necessary
code, but I don't remember whether it made it into test5 already (and
I don't have CONFIG_PERFMON enabled in my Ski setup).  If it's not
there already, it should be there tomorrow, as Linus pulled on the
ia64 repository a couple of hours ago.

	--david
