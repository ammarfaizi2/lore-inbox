Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbUBXSMy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 13:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbUBXSMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 13:12:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46817 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262378AbUBXSMs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 13:12:48 -0500
Date: Tue, 24 Feb 2004 10:10:55 -0800
From: "David S. Miller" <davem@redhat.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [IPSec] connect: Resource temporarily unavailable
Message-Id: <20040224101055.4f66ecff.davem@redhat.com>
In-Reply-To: <1077630520.799.7.camel@teapot.felipe-alfaro.com>
References: <1077630520.799.7.camel@teapot.felipe-alfaro.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004 14:48:41 +0100
Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> wrote:

> connect: Resource temporarily unavailable

Known behavior, and it's unlikely to be changing soon as doing the correct
thing here requires a lot of work.
