Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTGKTYe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 15:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTGKTXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 15:23:05 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60404 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S265110AbTGKTWj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 15:22:39 -0400
From: Andrew Theurer <habanero@us.ibm.com>
To: Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5 'what to expect'
Date: Fri, 11 Jul 2003 14:37:12 -0500
User-Agent: KMail/1.5
References: <20030711140219.GB16433@suse.de>
In-Reply-To: <20030711140219.GB16433@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307111437.12648.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 July 2003 09:02, Dave Jones wrote:
> Process scheduler improvements.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> - Scheduler is now Hyperthreading SMP aware and will disperse processes
>   over physically different CPUs, instead of just over logical CPUs.

I'm pretty sure this is not in 2.5 (unless it's in bk after 2.5.75)

-Andrew Theurer

