Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267424AbUIFDoo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267424AbUIFDoo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 23:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUIFDoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 23:44:44 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:45234
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267424AbUIFDoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 23:44:32 -0400
Date: Sun, 5 Sep 2004 20:42:10 -0700
From: "David S. Miller" <davem@davemloft.net>
To: simon@nuit.ca
Cc: linux-kernel@vger.kernel.org, simon@nuit.ca
Subject: Re: sig11 with sch_ingress in 2.6.8.1
Message-Id: <20040905204210.5cd1b1c6.davem@davemloft.net>
In-Reply-To: <20040905223644.GB19153@nuit.ca>
References: <20040905223644.GB19153@nuit.ca>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Known problem, fixed shortly afterwards in 2.6.9-rc1 and later.
