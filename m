Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUFVTo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUFVTo1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 15:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265058AbUFVTi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 15:38:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:32178 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265478AbUFVTgt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 15:36:49 -0400
Date: Tue, 22 Jun 2004 12:35:23 -0700
From: "David S. Miller" <davem@redhat.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: herbert@gondor.apana.org.au, kernel@nn7.de, linux-kernel@vger.kernel.org,
       benh@kernel.crashing.org, netdev@oss.sgi.com, jgarzik@pobox.com
Subject: Re: sungem - ifconfig eth0 mtu 1300 -> oops
Message-Id: <20040622123523.28fca55a.davem@redhat.com>
In-Reply-To: <40D847E3.2080109@nortelnetworks.com>
References: <20040621141144.119be627.davem@redhat.com>
	<40D847E3.2080109@nortelnetworks.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jun 2004 10:53:23 -0400
Chris Friesen <cfriesen@nortelnetworks.com> wrote:

> Just a quick question.  Does the sungem chip support jumbo frames?

Nope, not at all.
