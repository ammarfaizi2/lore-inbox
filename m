Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264154AbTCXL1P>; Mon, 24 Mar 2003 06:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264155AbTCXL1P>; Mon, 24 Mar 2003 06:27:15 -0500
Received: from dp.samba.org ([66.70.73.150]:65180 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264154AbTCXL1O>;
	Mon, 24 Mar 2003 06:27:14 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15998.60521.938276.311201@nanango.paulus.ozlabs.org>
Date: Mon, 24 Mar 2003 22:30:49 +1100 (EST)
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] PCMCIA patches
In-Reply-To: <20030312205659.C27656@flint.arm.linux.org.uk>
References: <20030312205659.C27656@flint.arm.linux.org.uk>
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King writes:

> I'm about to send a set of 6 PCMCIA patches, which I'd like people to
> test.  They're against base current 2.5.64 BK (as of this morning GMT,)
> but they apply with some offset to plain .64.

Just tried them on a G3 powerbook, and it all seems fine.  I plugged
in a CF card and a wireless ethernet card (both 16-bit pcmcia) and
they both worked.  I don't have any cardbus cards to try.

Paul.
