Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbTINUSq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 16:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261321AbTINUSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 16:18:46 -0400
Received: from smtp.slac.stanford.edu ([134.79.18.80]:61669 "EHLO
	smtp.slac.stanford.edu") by vger.kernel.org with ESMTP
	id S261298AbTINUSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 16:18:45 -0400
Date: Sun, 14 Sep 2003 13:18:43 -0700
From: Philip Clark <pclark@SLAC.Stanford.EDU>
Subject: Re: PCMCIA in 2.6.0-test5
In-reply-to: <20030914091051.A20889@flint.arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Message-id: <x348yor2kf0.fsf@bbrcu5.slac.stanford.edu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
References: <x34y8ws47an.fsf@bbrcu5.slac.stanford.edu>
 <20030914001539.D23169@flint.arm.linux.org.uk>
 <x34pti4453z.fsf@bbrcu5.slac.stanford.edu>
 <20030914091051.A20889@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Russell,

That was the problem, stupidly I had it compiled as module and somehow
it wasn't getting loaded. Once I compiled it into the kernel it seems to
work now so far. 

Also the problem in test4 where the wireless card was being detected as
a memory card seems to have fixed now :) 

Thanks a lot

-Phil
