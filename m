Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270430AbTGWQ0f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 12:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270432AbTGWQ0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 12:26:35 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:26636
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S270430AbTGWQ0e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 12:26:34 -0400
Date: Wed, 23 Jul 2003 09:41:40 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Message-ID: <20030723164140.GG1176@matchmail.com>
Mail-Followup-To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
	LKML <linux-kernel@vger.kernel.org>
References: <20030722013443.GA18184@netnation.com> <20030722172858.GB2880@home.woodlands> <1058899713.733.6.camel@teapot.felipe-alfaro.com> <20030722203716.GA1321@home.woodlands> <20030722213326.GB1176@matchmail.com> <20030723081811.GA1324@home.woodlands>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030723081811.GA1324@home.woodlands>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 23, 2003 at 01:48:11PM +0530, Apurva Mehta wrote:
> The problems do not end there. Once I start X, I experience
> random freezes of the system. In one session I could play some music
> and write some email. It froze just after dialing into the
> internet. In another session it froze while trying to start xmms.

please post the output of lspci here.  Also, what version of Xfree86 are you
running, and read the documentation for the nmi oopser in the kernel
documentation tree, and turn it on for your system.

Then we might be able to get a useful message out of your system.

Mike
