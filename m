Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSLPPs3>; Mon, 16 Dec 2002 10:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266777AbSLPPs3>; Mon, 16 Dec 2002 10:48:29 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:48287 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266774AbSLPPs2> convert rfc822-to-8bit;
	Mon, 16 Dec 2002 10:48:28 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andrew Theurer <habanero@us.ibm.com>
To: "Brian Jackson" <brian-kernel-list@mdrx.com>,
       "Scott Robert Ladd" <scott@coyotegulch.com>
Subject: Re: /proc/cpuinfo and hyperthreading
Date: Mon, 16 Dec 2002 09:52:35 -0600
User-Agent: KMail/1.4.3
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <FKEAJLBKJCGBDJJIPJLJEEKMDLAA.scott@coyotegulch.com> <20021216135453.3823.qmail@escalade.vistahp.com>
In-Reply-To: <20021216135453.3823.qmail@escalade.vistahp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212160952.35078.habanero@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 December 2002 07:54, Brian Jackson wrote:
> You could always boot once with nosmp and run some benchmarks and then
> reboot (with smp) and run some more benchmarks, and see if there is a
> difference.

Yes, but wouldn't booting a UP kernel be a better comparison?  After all, why 
incur any possible overhead of an SMP kernel if you don't need to?  Some 
benchmarks may not show a difference, but some definitely will.

-Andrew Theurer
