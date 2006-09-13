Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbWIMSsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbWIMSsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 14:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751105AbWIMSsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 14:48:08 -0400
Received: from us.cactii.net ([66.160.141.151]:19987 "EHLO us.cactii.net")
	by vger.kernel.org with ESMTP id S1751104AbWIMSsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 14:48:05 -0400
Date: Wed, 13 Sep 2006 20:47:33 +0200
From: Ben B <kernel@bb.cactii.net>
To: Michiel de Boer <x@rebelhomicide.demon.nl>
Cc: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: speedstep-centrino broke
Message-ID: <20060913184733.GB11161@cactii.net>
References: <20060912193810.GA20226@cactii.net> <4507B31A.8010001@rebelhomicide.demon.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4507B31A.8010001@rebelhomicide.demon.nl>
X-PGP-Key: 3CD061AD
X-PGP-Fingerprint: E092 32CA 6196 7C11 0692  BE43 AEDA 4D47 3CD0 61AD
Jabber-ID: bb@cactii.net
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I have the same problem, running kernel 2.6.17.13, and also get the 'No 
> such device' error.
> This problem doesn't occur when i boot 2.6.16.16, so the behaviour must 
> have been introduced
> somewhere in between.
> 
> Does it have anything to do with this thread? 
> http://lkml.org/lkml/2004/8/6/12

Not likely for mine - mine is a core duo - which is a dual core, and not
(to my knowledge) a Banias or Dothan chip. I get the problem with all
kernels I've tried (2.6.17.13, 2.6.18-rc4 as well as Ubuntu stock).
With the earlier BIOS, all kernels I tried happily had working cpufreq.

Ben

