Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265319AbUETXhl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265319AbUETXhl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 19:37:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265320AbUETXhl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 19:37:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29351 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265319AbUETXhk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 19:37:40 -0400
Date: Thu, 20 May 2004 16:37:34 -0700
From: "David S. Miller" <davem@redhat.com>
To: Andy Isaacson <adi@hexapodia.org>
Cc: jikos@jikos.cz, linux-kernel@vger.kernel.org, pekkas@netcore.fi
Subject: Re: [PATCH] IPv6 can't be built as module additionally
Message-Id: <20040520163734.4f436e62.davem@redhat.com>
In-Reply-To: <20040520233012.GA15699@hexapodia.org>
References: <Pine.LNX.4.58.0405210007240.25914@twin.jikos.cz>
	<20040520155042.223b05e3.davem@redhat.com>
	<20040520233012.GA15699@hexapodia.org>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 May 2004 18:30:13 -0500
Andy Isaacson <adi@hexapodia.org> wrote:

> Dave, would you be opposed to making IPv6 the default, with IPv4-only a
> selectable option under CONFIG_EMBEDDED or whatever umbrella "I know
> what I'm doing, let me remove vital parts of the kernel" config option
> is considered appropriate?

Not really, this has been discussed to death before.
