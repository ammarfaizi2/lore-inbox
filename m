Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263400AbTLCTNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 14:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265108AbTLCTNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 14:13:49 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:34434
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263400AbTLCTNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 14:13:47 -0500
Date: Wed, 3 Dec 2003 14:12:25 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
To: Vince <fuzzy77@free.fr>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, Mike Fedyk <mfedyk@matchmail.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [kernel panic @ reboot] 2.6.0-test10-mm1
In-Reply-To: <3FCDE506.7020302@free.fr>
Message-ID: <Pine.LNX.4.58.0312031409410.27578@montezuma.fsmlabs.com>
References: <3FC4DA17.4000608@free.fr> <Pine.LNX.4.58.0311261213510.1683@montezuma.fsmlabs.com>
 <3FC4E42A.40906@free.fr> <Pine.LNX.4.58.0311261240210.1683@montezuma.fsmlabs.com>
 <3FC4E8C8.4070902@free.fr> <Pine.LNX.4.58.0311261305020.1683@montezuma.fsmlabs.com>
 <20031126233738.GD1566@mis-mike-wstn.matchmail.com> <3FC53A3B.50601@free.fr>
 <20031202160303.2af39da0.rddunlap@osdl.org> <20031203003106.GF4154@mis-mike-wstn.matchmail.com>
 <20031202162745.40c99509.rddunlap@osdl.org> <3FCDE506.7020302@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003, Vince wrote:

> Well, I get indeed a nice oops on screen with this sysctl... but the
> oops/panic does not appear on the floppy dump  :-/
>
> --------------------------------------------------------
> <0>Kernel panic: Fatal exception
> <4> <0>Dumping messages in 100 seconds : last chance for
> Alt-SysRq...<6>SysRq :
> Emergency Sync
> <6>SysRq : Emergency Sync
> <6>SysRq : Emergency Remount R/O
> <6>SysRq : Trying to dump through real mode
> <4>
> ---------------------------------------------------------

Do you see any floppy disk activity at all? I'll see if i can come up with
something.
