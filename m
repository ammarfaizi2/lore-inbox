Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUDWXkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUDWXkQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 19:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbUDWXkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 19:40:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:3224 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261742AbUDWXkM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 19:40:12 -0400
Date: Fri, 23 Apr 2004 16:39:38 -0700
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: marcelo.tosatti@cyclades.com, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [PATCH] pktgen dependency (was: Re: Linux 2.4.27-pre1)
Message-Id: <20040423163938.013f362f.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.58.0404231644470.15793@waterleaf.sonytel.be>
References: <20040422130651.GB18358@logos.cnet>
	<Pine.GSO.4.58.0404231644470.15793@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004 16:58:58 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> The packet generator doesn't compile if procfs is disabled.
> IIRC, there was an agreement that this dependency is needed:

Applied, thanks Geert.  Can you cook up a 2.6.x variant as well
if that is needed too?

Thanks again.
