Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264453AbTEPOE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 10:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTEPOE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 10:04:29 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30527 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264453AbTEPOE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 10:04:29 -0400
From: Alan Cox <alan@redhat.com>
Message-Id: <200305161417.h4GEHJJ18387@devserv.devel.redhat.com>
Subject: Re: Incorrect AMD74xx UDMA100 test.
To: davej@codemonkey.org.uk
Date: Fri, 16 May 2003 10:17:19 -0400 (EDT)
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <200305150331.h4F3V5KB000583@deviant.impure.org.uk> from "davej@codemonkey.org.uk" at Mai 15, 2003 04:31:05 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We do 80wire comparisons based on an uninitialised var.
> Shouldn't we also be doing the 80wire check on the UDMA66 case ?

Yeah I thought that was fixed in 2.5.x and 2.4.x already
