Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269840AbUH0AIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269840AbUH0AIK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 20:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269838AbUH0AHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 20:07:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16286 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269823AbUH0AGy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 20:06:54 -0400
Date: Thu, 26 Aug 2004 17:06:39 -0700
From: "David S. Miller" <davem@redhat.com>
To: Joshua Kwan <joshk@triplehelix.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix bug in sparc64 user copy patch
Message-Id: <20040826170639.130f54fd.davem@redhat.com>
In-Reply-To: <412E7730.4050309@triplehelix.org>
References: <20040820155250.69c09781.davem@redhat.com>
	<412E7730.4050309@triplehelix.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Aug 2004 16:50:08 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> 1) clears the screen twice right after Remapping the kernel...

No idea.

> 2) omits every other character when it does start printing messages? such as

You're not following the list I guess...  I even posted about
this to debian-sparc, ho hum.

There is a problem with sunsab serial consoles, we're still
trying to figure out exactly what.  Note that console output
starts working properly once userland starts up.
