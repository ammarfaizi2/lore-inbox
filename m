Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266147AbUBJSQk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266063AbUBJSQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:16:39 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5290 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266147AbUBJSOs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:14:48 -0500
Date: Tue, 10 Feb 2004 10:14:37 -0800
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: greg@kroah.com, hch@infradead.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: dmapool (was: Re: Linux 2.6.3-rc2)
Message-Id: <20040210101437.1507af3b.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.58.0402101727130.2261@waterleaf.sonytel.be>
References: <Pine.LNX.4.58.0402091914040.2128@home.osdl.org>
	<Pine.GSO.4.58.0402101424250.2261@waterleaf.sonytel.be>
	<Pine.GSO.4.58.0402101531240.2261@waterleaf.sonytel.be>
	<20040210145558.A4684@infradead.org>
	<20040210162259.GA26620@kroah.com>
	<Pine.GSO.4.58.0402101727130.2261@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Feb 2004 17:29:15 +0100 (MET)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> Let's see what the sparc guys have to comment...

I think we'll just add the necessary stubs, it's not unreasonable.
