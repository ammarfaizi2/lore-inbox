Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265159AbUFAVhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265159AbUFAVhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 17:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUFAVhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 17:37:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33724 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265159AbUFAVhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 17:37:24 -0400
Date: Tue, 1 Jun 2004 14:36:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: alex@zodiac.dnsalias.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-mm1
Message-Id: <20040601143623.3ef8c164.davem@redhat.com>
In-Reply-To: <20040601143622.0717e85b.akpm@osdl.org>
References: <20040601021539.413a7ad7.akpm@osdl.org>
	<200406011351.10669@zodiac.zodiac.dnsalias.org>
	<20040601143622.0717e85b.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Jun 2004 14:36:22 -0700
Andrew Morton <akpm@osdl.org> wrote:

> Alexander Gran <alex@zodiac.dnsalias.org> wrote:
> > I can neither enter nor activate the gigabit ethernet driver section in 
> > menuconfig
> 
> I can, and nothing seems to have changed which would affect this.

It seems you have to enable the 10/100 section in order to get to
the gigabit section.  This is the case in the standard tree too,
nothing in -mm changed this.

