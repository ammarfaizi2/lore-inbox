Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264991AbUH3Wd2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264991AbUH3Wd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUH3Wd2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:33:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5248 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264704AbUH3Wcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:32:33 -0400
Date: Mon, 30 Aug 2004 15:31:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: neroden@fastmail.fm (Nathanael Nerode)
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3(Tigoon) & Kernel 2.4.27
Message-Id: <20040830153124.03aa84be.davem@redhat.com>
In-Reply-To: <20040830221638.GA3596@fastmail.fm>
References: <20040830221638.GA3596@fastmail.fm>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Aug 2004 18:16:38 -0400
neroden@fastmail.fm (Nathanael Nerode) wrote:

> >I guess if I ran objdump --disassemble on the image and
> >used the output of that in the tg3 driver and "compiled
> >that source" they'd be happy.  And this makes the situation
> >even more ludicrious.
> 
> Before you blithely made this claim, you should have actually tried running
> objdump --disassemble on the image.

I was speaking abstractly.  It is well definted which parts of
the hex arrays are the data, bss, and text sections.  It doesn't
take a rocket scientist to reconstruct things.
