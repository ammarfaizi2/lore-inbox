Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUAZXQN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAZXQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:16:13 -0500
Received: from sandershosting.com ([69.26.136.138]:416 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S265598AbUAZXQL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:16:11 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401261813.48324@sandersweb.net>
To: Adam Belay <ambx1@neo.rr.com>
Subject: Re: PNP depends on ISA ? (2.6.2-rc2
Date: Mon, 26 Jan 2004 18:15:43 -0500
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <20040126193144.GC2004@luna.mooo.com> <20040126161746.GA3180@neo.rr.com>
In-Reply-To: <20040126161746.GA3180@neo.rr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 January 2004 11:17 am, Adam Belay wrote:
> On Mon, Jan 26, 2004 at 09:31:44PM +0200, Micha Feigin wrote:
> > I was wondering why pnp depends on isa being selected in 2.6.2-rc2,

> Yes, it only is related to isa devices, but they include onboard
I the 2.4.x kernel I seem to remember being able to cat /proc/isapnp 
and getting info about pnp devices on my system.  Is there an 
equivalent in 2.6.x ?
- 
David Sanders
linux@sandersweb.net
