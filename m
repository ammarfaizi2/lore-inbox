Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261453AbTDBThR>; Wed, 2 Apr 2003 14:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261620AbTDBThR>; Wed, 2 Apr 2003 14:37:17 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:37034 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261453AbTDBThP>;
	Wed, 2 Apr 2003 14:37:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16011.16021.699436.97176@gargle.gargle.HOWL>
Date: Wed, 2 Apr 2003 21:48:37 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.4.21-pre6] update x86_64 for kernel_thread change
In-Reply-To: <1049311995.10050.47.camel@averell>
References: <16011.14209.703212.772185@gargle.gargle.HOWL>
	<1049311995.10050.47.camel@averell>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Wed, 2003-04-02 at 21:18, Mikael Pettersson wrote:
 > > Building an x86_64 kernel from 2.4.21-pre6 results in two linkage
 > > errors due to the recent kernel_thread to arch_kernel_thread name change.
 > > This patch updates x86_64 for that change.
 > 
 > You need more changes to fix the ptrace hole completely.

More generic fixes or more x86_64-specific fixes?

/Mikael
