Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317582AbSGXTVO>; Wed, 24 Jul 2002 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317586AbSGXTVO>; Wed, 24 Jul 2002 15:21:14 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:36340 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S317582AbSGXTVO>; Wed, 24 Jul 2002 15:21:14 -0400
Date: Wed, 24 Jul 2002 12:23:55 -0700
From: Chris Wright <chris@wirex.com>
To: Fabrizio Morbini <fabrizio.morbini@libero.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The Kernel and security patch...
Message-ID: <20020724122355.A16528@figure1.int.wirex.com>
Mail-Followup-To: Fabrizio Morbini <fabrizio.morbini@libero.it>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33L2.0207241827410.1010-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L2.0207241827410.1010-100000@localhost.localdomain>; from fabrizio.morbini@libero.it on Wed, Jul 24, 2002 at 06:30:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Fabrizio Morbini (fabrizio.morbini@libero.it) wrote:
> Hi, you are planning to insert into the kernel some security patch? (LIDS,
> MEDUSA DS9, RSBAC, GRSECURITY, ...)

We are working on intergrating LSM, http://lsm.immunix.org, into the
2.5 kernel.  Currently LIDS, SELinux and DTE are the most comprehensive
security patches ported to the LSM interface.  We looked at medusa and
rsbac when creating the LSM interface, feel free to port ;-)

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
