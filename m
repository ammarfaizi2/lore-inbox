Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269940AbTGKM4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 08:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269941AbTGKM4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 08:56:06 -0400
Received: from AMarseille-201-1-1-68.w193-252.abo.wanadoo.fr ([193.252.38.68]:25127
	"EHLO gaston") by vger.kernel.org with ESMTP id S269940AbTGKM4E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 08:56:04 -0400
Subject: Re: Linux 2.4.22-pre3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Paul Mackerras <paulus@samba.org>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.21.0307111459300.8989-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0307111459300.8989-100000@vervain.sonytel.be>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1057928999.504.4.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 11 Jul 2003 15:10:00 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-11 at 15:03, Geert Uytterhoeven wrote:
> On Sat, 5 Jul 2003, Marcelo Tosatti wrote:
> > Summary of changes from v2.4.22-pre2 to v2.4.22-pre3
> > ============================================
> > Benjamin Herrenschmidt <benh@kernel.crashing.org>:
> >   o ppc32: Update adbhid driver
> 
> This change breaks the build for Mac/m68k (cfr. 2.5.x). The patch below cures
> that, cfr. the similar so-far-unapplied patch for 2.5.x (it's CONFIG_ALL_PPC in
> 2.4.x and CONFIG_PPC_PMAC in 2.5.x, right)?

Right, I always forget you also use adbhid nowadays... sorry about that.

Ben.

