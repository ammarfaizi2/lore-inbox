Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTDHWzr (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:55:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbTDHWzr (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:55:47 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:60422 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S262482AbTDHWzp (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 18:55:45 -0400
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
From: James Bottomley <James.Bottomley@steeleye.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 08 Apr 2003 18:07:08 -0500
Message-Id: <1049843229.2107.46.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> As far as the 2.4.X series is concerned, pushing has not helped.  I've
> seen spelling fixes and incorrorct changes get accepted from non
> maintainers "instantly", while the maintainers changes are not
accepted.
> Considering how long it took for the last set of driver changes to
make
> it from -ac into kernel.org, I just assumed that this strategy was
> also failing.  Is that really the only way to get updates into
Marcelo's
> tree?

I take it 2.5 is up to date, right?  Because otherwise we should have
seen an update notice go across linux-scsi@vger.kernel.org.

This problem looks to be present in 2.5, so should I apply the patch?

James


