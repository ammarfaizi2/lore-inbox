Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUG0TzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUG0TzQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 15:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266525AbUG0TzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 15:55:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63657 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266522AbUG0TzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 15:55:11 -0400
Date: Tue, 27 Jul 2004 12:53:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Meelis Roos <mroos@linux.ee>
Cc: groudier@free.fr, linux-kernel@vger.kernel.org
Subject: Re: Sym53C896: CACHE INCORRECTLY CONFIGURED
Message-Id: <20040727125326.0c75a96c.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0407271038530.13593@ondatra.tartu-labor>
References: <Pine.LNX.4.58.0407271038530.13593@ondatra.tartu-labor>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 10:45:57 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> I got a 53c896 dual channel 64-bit PCI card (Compaq series EOB003). Tried
> it in x86 (i815 mainboard) and Sun Ultra 5 (both with 32-bit PCI slots).
> Both errored out basically the same way (this is from the PC, Linux
> 2.6.8-rc2):

I think your card is toast, if it fails like this it means that
even the most basic script cannot execute on the onboard processor.
