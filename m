Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264704AbUJET61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264704AbUJET61 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264726AbUJET5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:57:30 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:13704
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S264704AbUJETvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:51:48 -0400
Date: Tue, 5 Oct 2004 12:51:22 -0700
From: "David S. Miller" <davem@davemloft.net>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.8.1: Fix struct fddi_statistics for 64-bit
Message-Id: <20041005125122.58dedc38.davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.58L.0410040127280.22545@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.58L.0410040127280.22545@blysk.ds.pg.gda.pl>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Works for me, both 2.4.x and 2.6.x patches applied, thanks.
