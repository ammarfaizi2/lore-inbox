Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbTKTEf6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 23:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbTKTEf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 23:35:58 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:25827 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261332AbTKTEf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 23:35:56 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Nick Piggin <piggin@cyberone.com.au>
Date: Thu, 20 Nov 2003 15:35:02 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16316.17526.900850.239502@notabene.cse.unsw.edu.au>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Pontus Fuchs <pof@users.sourceforge.net>
Subject: Re: Announce: ndiswrapper
In-Reply-To: message from Nick Piggin on Thursday November 20
References: <20031120031137.GA8465@bougret.hpl.hp.com>
	<3FBC3483.4060706@pobox.com>
	<20031120040034.GF19856@holomorphy.com>
	<3FBC402E.6070109@cyberone.com.au>
X-Mailer: VM 7.17 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday November 20, piggin@cyberone.com.au wrote:
> 
> You have to admit its good for end users though. And indirectly, what
> is good for them is good for us. Take the nvidia example: end users get
> either a binary driver or nothing. If we were somehow able to stop
> nvidia from distributing their binary driver, they would say "OK".

Is it good for end users?  It allows them to buy a computer with an
nvidia graphics controller because "NVidia supply drivers", and then
discover that support is only as good as NVidia are willing to make
it.  I'm still waiting for some sort of power management support for
the nvidia controller in my notebook.  If the driver and the specs
were open, I could possibly do it myself.  On the other hand if there
were no NVidia drivers, I never would have made the (arguable) mistake
of buying this notebook.

Ofcourse we cannot and should not stop people from providing the
option of binary only drivers, but I'm not convinced that we should
acknowlege that people who provide binary-only drivers are doing a
useful service for anyone but themselves.

(fortuantely I could buy an alternate wireless card which does have
open-source drives.  It's not so easy to buy an alternate video
controler for a notebook - yet).

NeilBrown

