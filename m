Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264909AbUFBWjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264909AbUFBWjS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFBWjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:39:18 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5798 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264909AbUFBWjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:39:17 -0400
Date: Wed, 2 Jun 2004 15:37:57 -0700
From: "David S. Miller" <davem@redhat.com>
To: pjordan@whitehorse.blackwire.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel_unaligned_trap_fault -> undefined - sparc64
Message-Id: <20040602153757.38613ddc.davem@redhat.com>
In-Reply-To: <20040602175322.GA21878@panama>
References: <20040602175322.GA21878@panama>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You mentioned all the necessary information except for what kernel
version.  2.6.x has this problems fixed, so you must be trying out
2.4.x kernels.
