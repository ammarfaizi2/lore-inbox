Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276349AbRI1W2o>; Fri, 28 Sep 2001 18:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276324AbRI1W2f>; Fri, 28 Sep 2001 18:28:35 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62987 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S276353AbRI1W2Y>; Fri, 28 Sep 2001 18:28:24 -0400
Subject: Re: kernel changes
To: mark@somanetworks.com (Mark Frazer)
Date: Fri, 28 Sep 2001 23:33:39 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010928180452.A6093@somanetworks.com> from "Mark Frazer" at Sep 28, 2001 06:04:52 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15n6CR-00008r-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The answer is to treat all linus/ac/aa/... kernels as development
> kernels.  Don't treat anything as stable until it's been through
> a real QA cycle.  I've heard Suse, RedHat and the like don't do a
> bad job at this.

We try. If you want to QA your own kernel the cerberus test suite is
publically available - and indeed the VA guys are to thank for its origins.

Alan
