Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUFXTsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUFXTsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 15:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265339AbUFXTsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 15:48:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15311 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264646AbUFXTsD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 15:48:03 -0400
Date: Thu, 24 Jun 2004 12:47:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: hadi@znyx.com, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [NET]: Add tc extensions infrastructure.
Message-Id: <20040624124751.51a63e8e.davem@redhat.com>
In-Reply-To: <Pine.GSO.4.58.0406241658050.5358@waterleaf.sonytel.be>
References: <200406240108.i5O184QA014889@hera.kernel.org>
	<Pine.GSO.4.58.0406241658050.5358@waterleaf.sonytel.be>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2004 16:59:02 +0200 (MEST)
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +	  gathers stats that could be used to tune u32 classifier perfomance.
>                                                                   ^^^^^^^^^^
> performance

Thanks Geert, fixed in my tree.
