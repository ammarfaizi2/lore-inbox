Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964883AbWJXPa7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964883AbWJXPa7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 11:30:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWJXPa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 11:30:59 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33294 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S964883AbWJXPa6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 11:30:58 -0400
Date: Tue, 24 Oct 2006 16:30:54 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Lee Revell <rlrevell@joe-job.com>
cc: Wouter de Waal <wrm@ccii.co.za>, linux-kernel@vger.kernel.org
Subject: Re: FDDI on Linux kernel 2.6
In-Reply-To: <1161703237.3982.81.camel@mindpipe>
Message-ID: <Pine.LNX.4.64N.0610241628470.2511@blysk.ds.pg.gda.pl>
References: <5.0.0.25.2.20061024131939.05e4de70@alpha.ccii.co.za>
 <1161703237.3982.81.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Oct 2006, Lee Revell wrote:

> Most drivers will work on 64 bit without modification.  If it's not
> possible to make the driver 64 bit clean, then make it depend on
> !X86_64 (and any other 64 bit platform the hardware might be used on).

 Actually !64BIT is probably more appropriate.

  Maciej
