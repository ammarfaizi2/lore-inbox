Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUF1Dlc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUF1Dlc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 23:41:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUF1Dlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 23:41:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:34689 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264647AbUF1Dla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 23:41:30 -0400
Date: Sun, 27 Jun 2004 20:39:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove a superfluous #ifndef from net/ip.h
Message-Id: <20040627203915.65b56752.davem@redhat.com>
In-Reply-To: <20040627000222.GQ18303@fs.tum.de>
References: <20040627000222.GQ18303@fs.tum.de>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2004 02:02:23 +0200
Adrian Bunk <bunk@fs.tum.de> wrote:

> The patch below removes a superfluous #ifndef from net/ip.h (snmp.h is 
> guarded by the same #ifndef).
> 
> Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

Looks good to me, applied.

Thanks.
