Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbQKILZK>; Thu, 9 Nov 2000 06:25:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130254AbQKILZB>; Thu, 9 Nov 2000 06:25:01 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:46225 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S130133AbQKILYo>; Thu, 9 Nov 2000 06:24:44 -0500
From: Christoph Rohland <cr@sap.com>
To: richardj_moore@uk.ibm.com
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256992.002FE358.00@d06mta06.portsmouth.uk.ibm.com>
Organisation: SAP LinuxLab
Date: 09 Nov 2000 12:24:32 +0100
In-Reply-To: richardj_moore@uk.ibm.com's message of "Thu, 9 Nov 2000 07:43:09 +0000"
Message-ID: <qwwvgtxjslr.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Thu, 9 Nov 2000, richardj moore wrote:
> Let be clear about one thing: the GKHI make no statement about
> enabling proprietary extensions and that's a common
> misconception. GKHI is intended to make optional facilities easier
> to co-install and change. We designed it for DProbes, and when
> modularised will remain a GPL opensource offering.

Yes, I understand that.

> The only motivation for providing GKHI is to make the kernel more
> acceptable to the enterprise customer, but allowing, for example,
> RAS capabilities to be brough in easily and dynmaically. This type
> of customer will not readily succome to on-the-fly kernel rebuilds
> to diagnose problems that occur only in complex production
> environments.

I know this problem pretty well.

> If anything opens the door to proprietary extensions it's the
> loadable kernel modules capability or perhaps the loose wording of
> the GPL which doesn't catch loadable kernel modules, or
> whatever... Bottom line GKHI really has no bearing on this.

Yes, and that's why I am opposing here: Technically you are right, but
proposing that enterprise Linux should go this way is inviting binary
only modules due to the lax handling of modules.

Please keep in mind: I did not react to your announcement but to the
proposal that the companies should jump on it to do a special
enterprise Linux. If we really need a special enterprise tree lets do
it without module tricks.

Greetings
		Christoph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
