Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbTEYDdV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 23:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbTEYDdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 23:33:21 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:29571
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261294AbTEYDdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 23:33:20 -0400
Date: Sat, 24 May 2003 23:36:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Valdis.Kletnieks@vt.edu
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Fix NMI watchdog documentation 
In-Reply-To: <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>
Message-ID: <Pine.LNX.4.50.0305242335090.17353-100000@montezuma.mastecende.com>
References: <3ECFC2D6.2020007@gmx.net> <Pine.LNX.4.50.0305241505470.2267-100000@montezuma.mastecende.com>
            <Pine.LNX.4.50.0305241509380.2267-100000@montezuma.mastecende.com>
 <200305250329.h4P3TGoH004620@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 May 2003 Valdis.Kletnieks@vt.edu wrote:

> but 'dmesg' on my Dell Latitude C840 laptop tells me:
> 
> Dell Latitude with broken BIOS detected. Refusing to enable the local APIC.
> 
> Is this nmi_watchdog="forget about it dave" time, or is there some way to
> get this to work?

It's known broken with that configuration and hence blacklisted.

	Zwane
-- 
function.linuxpower.ca
