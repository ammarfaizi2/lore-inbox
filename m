Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTHSXyq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 19:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTHSXyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 19:54:46 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:16636 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261568AbTHSXyp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 19:54:45 -0400
Subject: Re: scheduler interactivity: timeslice calculation seem wrong
From: Eric St-Laurent <ericstl34@sympatico.ca>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <bhtt73$8i4$1@gatekeeper.tmr.com>
References: <3F41B43D.6000706@cyberone.com.au>
	 <1061276043.6974.33.camel@orbiter>  <bhtt73$8i4$1@gatekeeper.tmr.com>
Content-Type: text/plain
Message-Id: <1061337283.1123.8.camel@orbiter>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 19 Aug 2003 19:54:43 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This could go in 2.7, though, or possibly in 2.6.x depending on how the
> powers that be feel. I think having the scheduler as a plugin is a win
> in terms of having whole special-use algorithms. It would have to be
> done *very* carefully to be sure it didn't add measurable overhead.

Well i was thinking of a compile time or at best boot time selection. It
should not add any mesurable overhead.


