Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932282AbVLPMSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932282AbVLPMSH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 07:18:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932276AbVLPMSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 07:18:07 -0500
Received: from dtp.xs4all.nl ([80.126.206.180]:12346 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932282AbVLPMSG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 07:18:06 -0500
Date: Fri, 16 Dec 2005 13:17:54 +0100
From: Erik Mouw <erik@harddisk-recovery.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux@horizon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Message-ID: <20051216121754.GC18210@harddisk-recovery.com>
References: <20051215135812.14578.qmail@science.horizon.com> <Pine.LNX.4.64.0512150752240.3292@g5.osdl.org> <20051215165255.GA5510@harddisk-recovery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051215165255.GA5510@harddisk-recovery.com>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2005 at 05:52:55PM +0100, Erik Mouw wrote:
> Just FYI, according to Dijkstra[1] V means "verhoog" which is dutch for
> "increase". P means "prolaag" which isn't a dutch word, just something
> Dijkstra invented. I guess he did that because "decrease" is "verlaag"
> in dutch and that would give you the confusing V() and V()
> operations...

Last night I've been browsing a little more through Dijkstra's papers,
and in a completely unrelated paper[1] about a now obsolete computer I
found that "prolaag" is a neologism coming from "probeer te verlagen",
which means "try and decrease".


Erik

[1] http://www.cs.utexas.edu/users/EWD/transcriptions/EWD00xx/EWD51.html

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
