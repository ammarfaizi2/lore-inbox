Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbUD1Tws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUD1Tws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 15:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUD1Tw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 15:52:26 -0400
Received: from ultra12.almamedia.fi ([193.209.83.38]:48799 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S264994AbUD1RXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 13:23:47 -0400
Message-ID: <408FE8C4.33B3BDB4@users.sourceforge.net>
Date: Wed, 28 Apr 2004 20:24:20 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>,
       Vincent C Jones <vcjones@NetworkingUnlimited.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.6-rc3
References: <1PMQ9-5K6-3@gated-at.bofh.it> <20040428144801.B3708149A6@x23.networkingunlimited.com> <20040428160057.GA2252@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Apr 28, 2004 at 10:48:01AM -0400, Vincent C Jones wrote:
> > In article <1PMQ9-5K6-3@gated-at.bofh.it> you write:
> > >
> > >s390, cifs, ntfs, ppc, ppc64, cpufreq upates. Oh, and DVB and USB.
> > >
> > >I'm hoping to do a final 2.6.6 later this week, so I'm hoping as many
> > >people as possible will test this.
> > >
> > >     Thanks,
> > >
> > >             Linus
> >
> > loop-AES 2.0g has refused to compile since 2.6.6-rc1. No problems up
> > through 2.6.5. The make script cd's to the kernel source root, then
> > can't find any of the kernel include files, and it's all downhill from
> > there...
> 
> This is an external module - right?
> Could you mail me privately the Makefile used, or even better
> the full package (or link to it).

Full package:
http://loop-aes.sourceforge.net/loop-AES/loop-AES-v2.0g.tar.bz2

Patch to fix build problem:
http://loop-aes.sourceforge.net/updates/loop-AES-v2.0g-20040412.diff.bz2

New version of loop-AES will be released shortly after final 2.6.6 kernel is
released.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
