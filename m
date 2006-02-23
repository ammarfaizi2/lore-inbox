Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751787AbWBWUId@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751787AbWBWUId (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbWBWUId
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:08:33 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:41988 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1751787AbWBWUIc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:08:32 -0500
Message-ID: <43FE1615.6060008@shadowen.org>
Date: Thu, 23 Feb 2006 20:07:49 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> Does anybody want to run benchmarks? (Totally untested, may not boot, 
> might physically accost your pets for all I know).

Will throw this into the nightly tests and see what pops out.

-apw
