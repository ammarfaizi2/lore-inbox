Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265016AbUEYSFA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265016AbUEYSFA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 14:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265018AbUEYSE7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 14:04:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61643 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265016AbUEYSEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 14:04:55 -0400
Date: Tue, 25 May 2004 11:04:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vortech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: VLAN startup info patch
Message-Id: <20040525110417.1af91a93.davem@redhat.com>
In-Reply-To: <200405251144.44507.linux-kernel@vortech.net>
References: <200405251144.44507.linux-kernel@vortech.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004 11:44:44 -0400
Joshua Jackson <linux-kernel@vortech.net> wrote:

> Attached is a patch against the 2.4.26 802.1q vlan support header 
> (kernel/linux/net/8021q/vlan.h) to make the startup info obey the "quiet" 
> kernel parameter.

Applied, thanks.
