Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264889AbUBNHKW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 02:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264894AbUBNHKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 02:10:22 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10963 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264889AbUBNHKV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 02:10:21 -0500
Date: Fri, 13 Feb 2004 23:06:15 -0800
From: "David S. Miller" <davem@redhat.com>
To: jt@hpl.hp.com
Cc: jt@bougret.hpl.hp.com, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       shemminger@osdl.org
Subject: Re: [PATCH 2.6 IrDA] new driver : stir4200
Message-Id: <20040213230615.5849145c.davem@redhat.com>
In-Reply-To: <20040214015059.GA25979@bougret.hpl.hp.com>
References: <20040214015059.GA25979@bougret.hpl.hp.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004 17:50:59 -0800
Jean Tourrilhes <jt@bougret.hpl.hp.com> wrote:

> 	After a long maturation, this is time to send you the latest
> version of the stir4200 USB driver. Initially started by Paul Stewart,
> modified by Martin Diehl and me, and later partially rewriten by
> Stephen Hemminger.
 ...
> 	Would you mind pushing that to Linus ?

I'll queue this up for 2.6.4-pre1, thanks.

If you address Al Viro's concerns, just send me a relative patch with the
fix.  Thanks again.
