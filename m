Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264200AbUEHWCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264200AbUEHWCB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 18:02:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264193AbUEHWCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 18:02:01 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57482 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264195AbUEHWBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 18:01:42 -0400
Date: Sat, 8 May 2004 15:01:17 -0700
From: "David S. Miller" <davem@redhat.com>
To: James Morris <jmorris@redhat.com>
Cc: sds@epoch.ncsc.mil, chrisw@osdl.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, selinux@tycho.nsa.gov
Subject: Re: [PATCH][SELINUX] 1/2 sock_create_kern()
Message-Id: <20040508150117.4a88b81a.davem@redhat.com>
In-Reply-To: <Xine.LNX.4.44.0405071043540.21372-100000@thoron.boston.redhat.com>
References: <Xine.LNX.4.44.0405071043540.21372-100000@thoron.boston.redhat.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2004 11:05:10 -0400 (EDT)
James Morris <jmorris@redhat.com> wrote:

> The patch below adds a function sock_create_kern() for use when the kernel 
> creates sockets for its own use.

This looks fine, applied.
