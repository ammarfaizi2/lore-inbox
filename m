Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264692AbUGZAeh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbUGZAeh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jul 2004 20:34:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264697AbUGZAeh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jul 2004 20:34:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42978 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264692AbUGZAeg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jul 2004 20:34:36 -0400
Date: Sun, 25 Jul 2004 17:33:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6.8-rc1-mm1] ipv6/route.c gcc-341 fix inline
Message-Id: <20040725173324.01451f2b.davem@redhat.com>
In-Reply-To: <410381B4.1080302@kolivas.org>
References: <410381B4.1080302@kolivas.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jul 2004 19:47:32 +1000
Con Kolivas <kernel@kolivas.org> wrote:

> Fixes the inline error when compiling net/ipv6/route.c with gcc-3.4.1

Applied, thanks.

Please send this, just like any other networking patch,
to netdev@oss.sgi.com next time.


