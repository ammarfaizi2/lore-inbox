Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266778AbUGUXss@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266778AbUGUXss (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 19:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266779AbUGUXss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 19:48:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32449 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266778AbUGUXsq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 19:48:46 -0400
Date: Wed, 21 Jul 2004 16:44:33 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Delete cryptoloop
Message-Id: <20040721164433.202da6f1.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 16:16:34 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> I haven't updated the defconfigs, is this something for arch maintainers 
> to manage?

Yes, usually that is how things work out.
