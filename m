Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278068AbRJ3Vwn>; Tue, 30 Oct 2001 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278410AbRJ3Vwd>; Tue, 30 Oct 2001 16:52:33 -0500
Received: from freeside.toyota.com ([63.87.74.7]:60933 "EHLO toyota.com")
	by vger.kernel.org with ESMTP id <S278068AbRJ3Vwb>;
	Tue, 30 Oct 2001 16:52:31 -0500
Message-ID: <3BDF213C.12CD25E@lexus.com>
Date: Tue, 30 Oct 2001 13:53:00 -0800
From: J Sloan <jjs@lexus.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: [OT] Re: Nasty suprise with uptime
In-Reply-To: <E15yJD1-0003uO-00@the-village.bc.nu> <3BDDBE89.397E42C0@lexus.com> <20011030104751.A11623@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:

> On Mon, Oct 29, 2001 at 12:39:37PM -0800, J Sloan wrote:
>
> > So, is there an implicit Linux policy to upgrade
> > the distro, or at least the kernel, every 496 days
> > whether it needs it or not?
>
> Having huge uptimes is by the way not adviseable operational policy
> according to many.

Well, it is certainly a calling card for reliability.

> Chances are you will be in for a nasty surprise when you
> reboot -

not bloody likely - if such a case did exist, big
brother would let us know immediately that a
service is missing.

> do you remember after a year which daemons you 'started by hand'
> and how?

All daemons are started with init scripts. If init
scripts do not exist for a particular service, they
are created and activated with checkconfig.

In addition, all installed programs are in rpm
format, and  are installed in the most standard,
vanilla configuration possible.

cu

jjs

