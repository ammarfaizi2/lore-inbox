Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUEYRj5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUEYRj5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 13:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264990AbUEYRj5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 13:39:57 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24505 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264255AbUEYRj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 13:39:56 -0400
Date: Tue, 25 May 2004 10:38:43 -0700
From: "David S. Miller" <davem@redhat.com>
To: knobi@knobisoft.de
Cc: flind@haystack.mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Multicast problems between 2.4.20 and 2.4.21?
Message-Id: <20040525103843.0c764c47.davem@redhat.com>
In-Reply-To: <20040525094933.37642.qmail@web13906.mail.yahoo.com>
References: <40B25CFA.3000105@haystack.mit.edu>
	<20040525094933.37642.qmail@web13906.mail.yahoo.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You don't need a patch to force IGMPv2, there is a sysctl
available now in 2.4.x for this purpose.
