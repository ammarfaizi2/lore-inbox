Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266749AbUGUVvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266749AbUGUVvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266745AbUGUVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 17:51:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57240 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266743AbUGUVvq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 17:51:46 -0400
Date: Wed, 21 Jul 2004 14:47:40 -0700
From: "David S. Miller" <davem@redhat.com>
To: Roland Dreier <roland@topspin.com>
Cc: ultralinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix sparc64 build with CONFIG_COMPAT=n
Message-Id: <20040721144740.11bb8440.davem@redhat.com>
In-Reply-To: <52llhd2ira.fsf@topspin.com>
References: <52fz808qwy.fsf@topspin.com>
	<20040720200352.5c17b3f7.davem@redhat.com>
	<52llhd2ira.fsf@topspin.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 13:43:53 -0700
Roland Dreier <roland@topspin.com> wrote:

> Just out of curiousity, is there any practical use for sparc64 without
> CONFIG_COMPAT?  My impression was that everyone used 32-bit userspace
> (except for possibly a few executables).

Someone could build a 64-bit pure system.
