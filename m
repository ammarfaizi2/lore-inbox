Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262957AbVCDSLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVCDSLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 13:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVCDSLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 13:11:34 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:22029 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262951AbVCDSLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 13:11:18 -0500
Date: Fri, 4 Mar 2005 18:11:10 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Purdie <rpurdie@rpsys.net>, Jan Dittmer <jdittmer@ppp0.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
Message-ID: <20050304181110.A16178@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Purdie <rpurdie@rpsys.net>,
	Jan Dittmer <jdittmer@ppp0.net>, linux-kernel@vger.kernel.org
References: <42265023.20804@pobox.com> <Pine.LNX.4.58.0503021553140.25732@ppc970.osdl.org> <20050303002733.GH10124@redhat.com> <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <01ef01c520b7$94bebf80$0f01a8c0@max> <20050304132535.A9133@flint.arm.linux.org.uk> <039001c520e0$4ea3fbe0$0f01a8c0@max>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <039001c520e0$4ea3fbe0$0f01a8c0@max>; from rpurdie@rpsys.net on Fri, Mar 04, 2005 at 05:33:33PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 05:33:33PM -0000, Richard Purdie wrote:
> I'm in two minds though as generating 
> your own from openembedded isn't difficult. Writing instructions for setting 
> up oe to build it may be the best option.

Two things - are you sure that openembedded contains the patches to
fix the two biggest binutils issues we have, as documented on
http://www.arm.linux.org.uk/developer/toolchain/ ?

Secondly, are you seriously suggesting people like Jan Dittmer, who
provide a cross-architecture service should jump through some loops
just to get a working toolchain for the ARM architecture?

Jan, how do you feel about this?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
