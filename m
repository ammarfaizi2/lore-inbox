Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUJZDiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUJZDiv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 23:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbUJZDgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 23:36:39 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:31965
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S262138AbUJZDbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 23:31:55 -0400
Date: Mon, 25 Oct 2004 20:24:31 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.9] Ooops in fib_release_info (fib_semantics.c) with quagga
Message-Id: <20041025202431.555e5b84.davem@davemloft.net>
In-Reply-To: <20041022134938.27174.qmail@thales.mathematik.uni-ulm.de>
References: <20041022134938.27174.qmail@thales.mathematik.uni-ulm.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Oct 2004 15:49:38 +0200
Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de> wrote:

> Signed-off-by: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>

Good catch Christian, patch applied.

Please post your report and patch to netdev@oss.sgi.com next
time, that is where the Linux networking developers listen.

Thanks.
