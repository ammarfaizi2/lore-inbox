Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266001AbUA1XDv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 18:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266039AbUA1XDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 18:03:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:14799 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266001AbUA1XDt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 18:03:49 -0500
Date: Wed, 28 Jan 2004 15:03:43 -0800
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: jlcooke@certainkey.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto/sha256.c crypto/sha512.c
Message-Id: <20040128150343.3bab6092.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0401281706181.8922-100000@thoron.boston.redhat.com>
References: <20040128213050.GB23977@certainkey.com>
	<Xine.LNX.4.44.0401281706181.8922-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jan 2004 17:08:58 -0500 (EST)
James Morris <jmorris@redhat.com> wrote:

> On Wed, 28 Jan 2004, Jean-Luc Cooke wrote:
> 
> > Pardon my ignorance, but does silence mean "yes"?
> 
> No, but the patch looks fine to me and passes the test vectors.
> 
> Dave, I've included it below.

Applied, thanks guys.
