Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263661AbUDVWgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263661AbUDVWgx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 18:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUDVWgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 18:36:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59024 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263661AbUDVWgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 18:36:43 -0400
Date: Thu, 22 Apr 2004 15:35:15 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: ak@muc.de, jmorris@redhat.com, linux-kernel@vger.kernel.org,
       vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Large inlines in include/linux/skbuff.h
Message-Id: <20040422153515.65a44f16.davem@redhat.com>
In-Reply-To: <20040422223401.GB81305@colin2.muc.de>
References: <m3y8ooawiq.fsf@averell.firstfloor.org>
	<Xine.LNX.4.44.0404221114500.22706-100000@thoron.boston.redhat.com>
	<20040422222326.GA81305@colin2.muc.de>
	<20040422152525.28ee1d5f.davem@redhat.com>
	<20040422223401.GB81305@colin2.muc.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Apr 2004 00:34:01 +0200
Andi Kleen <ak@muc.de> wrote:

> All it does it is to lower the cache foot print, not enlarge it.
> So even if it made a difference it could only get better.
> It's extremly unlikely to make it detectable worse.

That's a good argument.  I would still like to see some
numbers, you know to help me sleep at night :-)
