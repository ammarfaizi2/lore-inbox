Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbTLDBfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbTLDBfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:35:31 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:23984 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S262323AbTLDBfW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:35:22 -0500
Date: Wed, 3 Dec 2003 17:34:08 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Vince <fuzzy77@free.fr>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
Message-ID: <20031204013408.GE29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Vince <fuzzy77@free.fr>,
	Zwane Mwaikambo <zwane@holomorphy.com>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com> <20031126233738.GD1566@mis-mike-wstn.matchmail.com> <3FC53A3B.50601@free.fr> <20031202160303.2af39da0.rddunlap@osdl.org> <20031203003106.GF4154@mis-mike-wstn.matchmail.com> <20031202162745.40c99509.rddunlap@osdl.org> <3FCDE506.7020302@free.fr> <Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com> <3FCE877B.3010703@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCE877B.3010703@free.fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 02:01:47AM +0100, Vince wrote:
> Zwane Mwaikambo wrote:
> >On Wed, 3 Dec 2003, Vince wrote:
> >
> >
> >>Well, I get indeed a nice oops on screen with this sysctl... but the
> >>oops/panic does not appear on the floppy dump  :-/
> >>
> >>--------------------------------------------------------
> >><0>Kernel panic: Fatal exception
> >><4> <0>Dumping messages in 100 seconds : last chance for
> >>Alt-SysRq...<6>SysRq :
> >>Emergency Sync
> >><6>SysRq : Emergency Sync
> >><6>SysRq : Emergency Remount R/O
> >><6>SysRq : Trying to dump through real mode
> >><4>
> >>---------------------------------------------------------
> >
> >
> >Do you see any floppy disk activity at all? I'll see if i can come up with
> >something.
> 
> Yes, there *is* floppy activity. The previous messages make it to the 
> floppy (in that case, I experienced with 
> Alt-Sysrq+S/Alt-Sysrq+U/Alt-Sysrq+D), but the oops doesn't...

do you mean s/Alt-Sysrq+D/Alt-Sysrq+B/  ?

On 2.4 there isn't a Alt-Sysrq+D, but maybe there is on 2.6...?
