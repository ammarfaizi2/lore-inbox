Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTALXP4>; Sun, 12 Jan 2003 18:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTALXP4>; Sun, 12 Jan 2003 18:15:56 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:59827 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267642AbTALXPn> convert rfc822-to-8bit; Sun, 12 Jan 2003 18:15:43 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Bill Davidsen <davidsen@tmr.com>
Subject: Re: [Lse-tech] Minature NUMA scheduler
Date: Mon, 13 Jan 2003 00:24:48 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <Pine.LNX.3.96.1030111094032.8637A-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030111094032.8637A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301130024.48571.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 January 2003 15:43, Bill Davidsen wrote:
> Agreed, but honestly just this explanation would make it easier to
> understand! I'm not sure you have the "balance of nodes" trigger defined
> quite right, but I'm assuming if this gets implemented as described that
> some long term umbalance detector mechanism will be run occasionally.

Yes, the current plan is to extend the miniature NUMA scheduler by a
inter-node balancer which is called less frequently.

Regards,
Erich


