Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUFEWcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUFEWcW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Jun 2004 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbUFEWcW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Jun 2004 18:32:22 -0400
Received: from mx1.redhat.com ([66.187.233.31]:21186 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262071AbUFEWcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Jun 2004 18:32:17 -0400
Date: Sat, 5 Jun 2004 15:29:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andreas Schwab <schwab@suse.de>
Cc: olh@suse.de, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] compat bug in sys_recvmsg, MSG_CMSG_COMPAT check
 missing
Message-Id: <20040605152949.785a9e41.davem@redhat.com>
In-Reply-To: <jeise57j95.fsf@sykes.suse.de>
References: <20040605204334.GA1134@suse.de>
	<20040605140153.6c5945a0.davem@redhat.com>
	<20040605140544.0de4034d.davem@redhat.com>
	<jer7st7lam.fsf@sykes.suse.de>
	<20040605143649.3fd6c22b.davem@redhat.com>
	<jen03h7k45.fsf@sykes.suse.de>
	<20040605145333.11c80173.davem@redhat.com>
	<jeise57j95.fsf@sykes.suse.de>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Jun 2004 00:05:58 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Can you say DeMorgan?

Sorry, thought I had put enough caffeine in my system.
Aparently not :)
