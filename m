Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262787AbVDASsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262787AbVDASsS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 13:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVDASp2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 13:45:28 -0500
Received: from graphe.net ([209.204.138.32]:44041 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S262851AbVDASli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 13:41:38 -0500
Date: Fri, 1 Apr 2005 10:41:29 -0800 (PST)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.graphe.net
To: Andrew Morton <akpm@osdl.org>
cc: Linus Torvalds <torvalds@osdl.org>, oleg@tv-sign.ru,
       linux-kernel@vger.kernel.org, mingo@elte.hu, kenneth.w.chen@intel.com
Subject: Re: [RFC][PATCH] timers fixes/improvements
In-Reply-To: <20050401103235.1fcea9f0.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0504011041001.9755@server.graphe.net>
References: <424D373F.1BCBF2AC@tv-sign.ru> <Pine.LNX.4.58.0504010807570.4774@ppc970.osdl.org>
 <20050401103235.1fcea9f0.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Apr 2005, Andrew Morton wrote:

> Sure.  Christoph and (I think) Ken have been seeing mysterious misbehaviour
> which _might_ be due to Oleg's first round of timer patches.  I assume C&K
> will test this new patch?

Yes will be tested. The hangs disappeared here when we removed Oleg's
patches.
