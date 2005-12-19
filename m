Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVLSIqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVLSIqD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbVLSIqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:46:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39086 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030288AbVLSIqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:46:02 -0500
Subject: Re: Light-weight dynamically extended stacks
From: Arjan van de Ven <arjan@infradead.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051219001249.GD11856@waste.org>
References: <20051219001249.GD11856@waste.org>
Content-Type: text/plain
Date: Mon, 19 Dec 2005 09:45:56 +0100
Message-Id: <1134981956.2947.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> While we have a good handle on most of the worst stack offenders, we
> can still run into trouble with pathological cases (say, symlink
> recursion for XFS on a RAID built from loopback mounts over NFS
> tunneled over IPSEC through GRE). So there's probably no
> one-size-fits-all when it comes to stack size.

this is pure conjecture at this time, not a fact. You post it as a fact
here... Have you tried something like this to see the layers you add
actually add stack??

