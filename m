Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261258AbUDSXhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbUDSXhZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 19:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbUDSXhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 19:37:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43736 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261258AbUDSXhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 19:37:23 -0400
Date: Mon, 19 Apr 2004 16:36:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Clay Haapala <chaapala@cisco.com>
Cc: jmorris@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/crc32c implementation, updated 040419
Message-Id: <20040419163622.7834f23a.davem@redhat.com>
In-Reply-To: <yqujwu4by7qs.fsf_-_@chaapala-lnx2.cisco.com>
References: <Xine.LNX.4.44.0403261134210.4331-100000@thoron.boston.redhat.com>
	<yqujn05yi67c.fsf@chaapala-lnx2.cisco.com>
	<yqujwu4by7qs.fsf_-_@chaapala-lnx2.cisco.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Apr 2004 16:31:55 -0500
Clay Haapala <chaapala@cisco.com> wrote:

> This patch agains 2.6.6-rc1-bk implements the CRC32C algorithm as a
> type of digest.  It is implemented as a wrapper for libcrc32c,
> available in a separate patch.  The crypto CRC32C module will be
> used by the iscsi-sfnet driver.

James, you got these two bits?
