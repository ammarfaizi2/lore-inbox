Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbUDAHGv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 02:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUDAHGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 02:06:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:10654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261942AbUDAHGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 02:06:50 -0500
Date: Wed, 31 Mar 2004 23:05:55 -0800
From: "David S. Miller" <davem@redhat.com>
To: Sridhar Samudrala <sri@us.ibm.com>
Cc: petero2@telia.com, marcelo.tosatti@cyclades.com, vladislav.yasevich@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.26-rc1 - SCTP 'make xconfig' issue
Message-Id: <20040331230555.5c635e40.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
References: <20040328042608.GA17969@logos.cnet>
	<m2r7vcss6a.fsf@p4.localdomain>
	<Pine.LNX.4.58.0403311418470.7023@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2004 16:47:04 -0800 (PST)
Sridhar Samudrala <sri@us.ibm.com> wrote:

> He came up with the following patch that works around this issue with
> tkparse.  Could you please verify if this works for you?

It seems to fix the problem, should I apply this Sridhar?
