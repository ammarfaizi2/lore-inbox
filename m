Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUIOU0t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUIOU0t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUIOUZF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:25:05 -0400
Received: from mail03.powweb.com ([66.152.97.36]:19 "EHLO mail03.powweb.com")
	by vger.kernel.org with ESMTP id S267380AbUIOUXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:23:18 -0400
From: "David Dabbs" <david@dabbs.net>
To: "'ReiserFS List'" <reiserfs-list@namesys.com>,
       <linux-kernel@vger.kernel.org>, <linux-fsdev@vger.rutgers.edu>
Cc: "'Timothy Miller'" <miller@techsource.com>
Subject: RE: silent semantic changes with reiser4
Date: Wed, 15 Sep 2004 15:23:02 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
thread-index: AcSbYFK4cKdThOjSRj2dw5mNMqbUrAAABM8Q
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
In-Reply-To: <20040915201239.9F1FB15D5E@mail03.powweb.com>
Message-Id: <20040915202316.730DC15D7B@mail03.powweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I'm probably not the first to suggest this idea, and it's probably not a
> very good idea, but here's my idea anyhow:
> 
> You have a file "/usr/bin/emacs"
> with a metadata property in the overlaid namespace
> "/usr/bin/emacs/[[..]metas/]icon"
> 
> According to some, this could cause some confusion.  Howabout instead:
> 
> You have a file "/usr/bin/emacs"
> with a metadata property in a slightly separated namespace
> "/metas/usr/bin/emacs/icon"
>

Timothy, see my similar proposal at
http://marc.theaimsgroup.com/?l=reiserfs&m=109511131923831&w=2 
which viro vetoed. I suspect this horse is quite dead.


David




