Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263705AbTJ0Azy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 19:55:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTJ0Azy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 19:55:54 -0500
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:45697
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S263705AbTJ0Azx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 19:55:53 -0500
Date: Sun, 26 Oct 2003 19:55:25 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: =?iso-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
cc: linux-kernel@vger.kernel.org
Subject: RE: [BUG] R8169 on 2.6.0-test9
In-Reply-To: <066301c39c1a$ed75d0f0$034d210a@sandos>
Message-ID: <Pine.LNX.4.53.0310261954230.20169@montezuma.fsmlabs.com>
References: <066301c39c1a$ed75d0f0$034d210a@sandos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Oct 2003, John Bäckstrand wrote:

> >The r8169 gigabit ethernet card causes lockups on both 2.4.22 and
> 2.6.0-test9.
> 
> It does it even on 2.4.20 and using the 8139cp. Heres lspci -vvv, starting
> to wonder if this card is special/odd/unsupported or if its just this
> hardware not being happy.

This is bug report is somewhat confusing, are you using r8169.c 
(CONFIG_R8169)?
