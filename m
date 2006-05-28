Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWE1Ift@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWE1Ift (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 04:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWE1Ift
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 04:35:49 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12437 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932086AbWE1Ifs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 04:35:48 -0400
Subject: Re: [PATCH] inotify kernel API
From: Arjan van de Ven <arjan@infradead.org>
To: Amy Griffis <amy.griffis@hp.com>
Cc: John McCutchan <john@johnmccutchan.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Robert Love <rlove@rlove.org>
In-Reply-To: <20060528024245.GA18625@zk3.dec.com>
References: <20060526021030.GA4936@zk3.dec.com>
	 <1148659946.7612.7.camel@localhost.localdomain>
	 <20060528024245.GA18625@zk3.dec.com>
Content-Type: text/plain
Date: Sun, 28 May 2006 10:35:42 +0200
Message-Id: <1148805342.3074.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-05-27 at 22:42 -0400, Amy Griffis wrote:
> John McCutchan wrote:     [Fri May 26 2006, 12:12:26PM EDT]
> > Having only glanced at your latest code, all of your changes and bug
> > fixes look good. Thanks very much for putting the effort into auditing
> > and testing inotify. 
> 
> Thanks, that's great to hear.

btw is the user of this in-kernel stuff also included?

