Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbTD1INb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 04:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262284AbTD1INb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 04:13:31 -0400
Received: from ns.suse.de ([213.95.15.193]:1808 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261605AbTD1INa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 04:13:30 -0400
To: jlnance@unity.ncsu.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: ia32 kernel on amd64 box?
References: <20030425214500.GA20221@ncsu.edu>
From: Andreas Jaeger <aj@suse.de>
In-Reply-To: <20030425214500.GA20221@ncsu.edu> (jlnance@unity.ncsu.edu's
 message of "Fri, 25 Apr 2003 17:45:00 -0400")
Date: Mon, 28 Apr 2003 10:24:39 +0200
Message-ID: <hoof2rghbs.fsf@byrd.suse.de>
User-Agent: Gnus/5.09002 (Oort Gnus v0.20) XEmacs/21.4 (Portable Code,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jlnance@unity.ncsu.edu writes:

> Hello All,
>     Does anyone know if an ia32 kernel (specifically the one that comes with
> Red Hat 7.2) will work on an SMP AMD Opteron machine?

Any 32-bit x86 kernel should work on an AMD Opteron machine.  The only
question is whether all drivers are supported.  Red Hat 7.2 might not
have support for all the hardware that is in an AMD Opteron ystem.

>     I know someone will want to know why I would want to, so here is the
> explanation.  I want to evaluate the opteron port of Linux at work.  Buying
> the Opteron machine is less risky if I can fall back to 32 bit Linux
> if the 64 bit port does not work well.  This is particularly true since
> the 64 bit servers do not seem to cost much more than similar Pentium
> machines.

SuSE Linux 8.2/x86 works on AMD Opteron systems and I guess current
Red Hat distributions do work also,

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
