Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUH0U1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUH0U1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267465AbUH0UNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 16:13:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18370 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267470AbUH0UCN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 16:02:13 -0400
Date: Fri, 27 Aug 2004 13:01:51 -0700
From: "David S. Miller" <davem@redhat.com>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Message-Id: <20040827130151.46c246b0.davem@redhat.com>
In-Reply-To: <412F4008.4050700@winischhofer.net>
References: <412F4008.4050700@winischhofer.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004 16:07:04 +0200
Thomas Winischhofer <thomas@winischhofer.net> wrote:

> OK and if the authors of, say, SMP support say "back it out", Linux ends 
> up without SMP support. Cool.

If you could get each and every author of SMP support to agree,
sure.  But good luck getting that is quite a large group of
folks and since Linus is one of those authors.

And last I checked, no binary-only module hooks were added to
the SMP support recently, so nothing for them to get upset
about. :-)

