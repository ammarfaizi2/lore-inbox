Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265183AbUELTZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265183AbUELTZh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 15:25:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265176AbUELTYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 15:24:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5601 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265184AbUELTI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 15:08:28 -0400
Date: Wed, 12 May 2004 12:06:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: kiza@gmx.net, linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] Re: CONFIG_ATALK cannot be compiled as a module
Message-Id: <20040512120622.7b473af5.davem@redhat.com>
In-Reply-To: <20040510235343.GD18093@fs.tum.de>
References: <20040510235343.GD18093@fs.tum.de>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004 01:53:43 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> patch description:
> - net/Makefile: there might be modules in net/802/
> - net/802/Makefile: deuglyfy it and make it more similar to the
>                     2.6 version

Applied, thanks Adrian.
