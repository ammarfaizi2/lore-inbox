Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265944AbUBCIyz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 03:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265954AbUBCIyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 03:54:55 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:51721 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265944AbUBCIy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 03:54:27 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: broken maxcpus in 2.4.24
Date: Tue, 3 Feb 2004 09:53:30 +0100
User-Agent: KMail/1.5.4
References: <1075765034.17943.79.camel@reactor.us.proofpoint.com>
In-Reply-To: <1075765034.17943.79.camel@reactor.us.proofpoint.com>
Cc: Dan Christian <dac@proofpoint.com>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402030953.30429@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 February 2004 00:37, Dan Christian wrote:

Hi Dan,

> I compiled a vanilla 2.4.24 for a 2 processor Xeon.
> I set CONFIG_NR_CPUS to 4 (2 CPUs x 2 hyperthreads each).
> When I boot the kernel, /proc/cpuinfo only shows 2 cpus (0-1) and
> performance is bad.
> I reconfigure CONFIG_NR_CPUS back to 32.  Now it shows 4 cpus (0-3) and
> performance is normal.
> Is this a bug or am misunderstanding how to set this configuration
> variable?

http://linux.bkbits.net:8080/linux-2.4/cset@1.1136.1.68?nav=index.html|
ChangeSet@-12w

ciao, Marc

