Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267852AbUHRVwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267852AbUHRVwK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267849AbUHRVwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:52:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267841AbUHRVwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:52:02 -0400
Date: Wed, 18 Aug 2004 14:47:28 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: bunk@fs.tum.de, acme@conectiva.com.br, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [2.6 patch] atalk compile errors with SYSCTL=n
Message-Id: <20040818144728.5f5734c4.davem@redhat.com>
In-Reply-To: <20040811170101.69c140b6@dell_ss3.pdx.osdl.net>
References: <20040811224747.GQ26174@fs.tum.de>
	<20040811170101.69c140b6@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Aug 2004 17:01:01 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> I prefer to have the CONFIG stuff in the header file.
> Here is an alternative that rearranges to put all function
> prototypes in atalk.h and stubs if necessary. It gets all the #ifdef
> CONFIG_ stuff out of the .c files.

Applied, thanks Stephen.

