Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267285AbUHPACp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267285AbUHPACp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 20:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267287AbUHPACp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 20:02:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60577 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267285AbUHPACo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 20:02:44 -0400
Date: Sun, 15 Aug 2004 17:00:22 -0700
From: "David S. Miller" <davem@redhat.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: hch@infradead.org, zwane@linuxpower.ca, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH][2.6] Move Sungem to gige menu
Message-Id: <20040815170022.2c3ec056.davem@redhat.com>
In-Reply-To: <1092608813.9536.21.camel@gaston>
References: <Pine.LNX.4.58.0408141412550.22077@montezuma.fsmlabs.com>
	<20040815104900.A805@infradead.org>
	<Pine.LNX.4.58.0408151103490.22078@montezuma.fsmlabs.com>
	<Pine.LNX.4.58.0408151116520.22078@montezuma.fsmlabs.com>
	<20040815162129.A2700@infradead.org>
	<1092608813.9536.21.camel@gaston>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 08:26:53 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> I suppose the ones used by Sun are all gigabit tho.

Actually no, the ones onboard in the SunBlade100 are
10/100 only.
