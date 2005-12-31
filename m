Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbVLaRCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbVLaRCg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 12:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbVLaRCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 12:02:36 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:20193 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S965025AbVLaRCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 12:02:35 -0500
Date: Sat, 31 Dec 2005 19:02:31 +0200
From: Sami Farin <7atbggg02@sneakemail.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: system keeps freezing once every 24 hours / random apps crashing
Message-ID: <20051231170231.GF3214@m.safari.iki.fi>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
References: <200512310051.03603.s0348365@sms.ed.ac.uk> <43B5D6D0.9050601@ns666.com> <43B65DEE.906@ns666.com> <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com> <43B66E3D.2010900@ns666.com> <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com> <43B67DB6.2070201@ns666.com> <43B6A14E.1020703@ns666.com> <20051231163414.GE3214@m.safari.iki.fi> <43B6B669.6020500@ns666.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43B6B669.6020500@ns666.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2005 at 05:48:41PM +0100, Mark v Wolher wrote:
> Sami Farin wrote:
...
> > Can you try how many seconds it takes to get Oops/crash when you start
> > pressing 'v' in xawtv (video capture on/off).
> > For me, not very many.
> > 
> > This happens with every 2.6 kernel.  And my hardware is OK.
...
> Hi Sami,
> 
> That caused also a crash, i kept pressing the v key and within 15
> seconds it crashed, then i saw the crash-info appear in the log and when
> i clicked on mozilla then it crashed too but without crahs info and
> system froze totally.

Now if someone could figure out how to find the bug in bttv.
My opinion/guess is that's where the bug is, not in buggy PCI hardware,
as somebody said several months ago.

-- 
