Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266071AbUF2VZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266071AbUF2VZI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266073AbUF2VZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:25:07 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32434 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266071AbUF2VZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:25:00 -0400
Date: Tue, 29 Jun 2004 14:24:26 -0700
From: "David S. Miller" <davem@redhat.com>
To: Patrick McHardy <kaber@trash.net>
Cc: wichert@wiggy.net, coreteam@netfilter.org, linux-kernel@vger.kernel.org
Subject: Re: [netfilter-core] undefined reference to
 `ip_conntrack_untracked'
Message-Id: <20040629142426.6a146340.davem@redhat.com>
In-Reply-To: <40E18A8A.4060500@trash.net>
References: <20040629140234.GT13365@wiggy.net>
	<40E18A8A.4060500@trash.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004 17:28:10 +0200
Patrick McHardy <kaber@trash.net> wrote:

> Please try this patch.

Looks good to me, applied.
