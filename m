Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262127AbUKDHZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbUKDHZb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 02:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262113AbUKDHYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 02:24:53 -0500
Received: from smtp-out-02.utu.fi ([130.232.202.172]:1017 "EHLO
	smtp-out-02.utu.fi") by vger.kernel.org with ESMTP id S262127AbUKDHT5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 02:19:57 -0500
Date: Thu, 04 Nov 2004 09:19:54 +0200
From: Jan Knutar <jk-lkml@sci.fi>
Subject: Re: is killing zombies possible w/o a reboot?
In-reply-to: <200411031608.49543.gene.heskett@verizon.net>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, Tom Felker <tfelker2@uiuc.edu>
Message-id: <200411040919.54226.jk-lkml@sci.fi>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: KMail/1.6.2
References: <200411030751.39578.gene.heskett@verizon.net>
 <200411031448.38110.tfelker2@uiuc.edu>
 <200411031608.49543.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 November 2004 23:08, Gene Heskett wrote:

> Its a dead horse Tom, lets bury it.  I've rebooted to 4 new kernels 
> since that time as I march toward getting caught up with whatever 
> bk(nn) is out today.  Other than that, which took place on bk7's 
> watch, its all working rather well.

Since nobody else seems to have said it, it would be a good idea
to enable sysrq and do a sysrq-T the next time (if) this happens,
so that there would be atleast some information to go on.
