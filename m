Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261382AbTDCQnT>; Thu, 3 Apr 2003 11:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261385AbTDCQnT>; Thu, 3 Apr 2003 11:43:19 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:35985 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S261382AbTDCQnR>;
	Thu, 3 Apr 2003 11:43:17 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16012.26449.528594.682130@gargle.gargle.HOWL>
Date: Thu, 3 Apr 2003 18:54:41 +0200
From: mikpe@csd.uu.se
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.66 x86_64 oops when swapoff via IA32 emulation
In-Reply-To: <20030403151642.GB2062@wotan.suse.de>
References: <16012.19359.948383.217572@enequist.it.uu.se>
	<20030403151642.GB2062@wotan.suse.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:
 > On Thu, Apr 03, 2003 at 04:56:31PM +0200, mikpe@csd.uu.se wrote:
 > > I got this oops from swapoff when shutting down 2.5.66 on
 > > x86_64 with 32-bit user-space (RH8.0). This was from the first
 > > run with 2.5.66, I wasn't able to reproduce it in later runs.
 > 
 > Is this on the Simulator or on a real Opteron/Athlon64? 

Simics.

/Mikael
