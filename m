Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261996AbVACXlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbVACXlH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 18:41:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261980AbVACXka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 18:40:30 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56277 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261992AbVACXkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 18:40:02 -0500
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20050103171937.GG2980@stusta.de> <52sm5i70um.fsf@topspin.com>
	<20050103231024.GP2980@stusta.de> <524qhy6qpg.fsf@topspin.com>
	<20050103233449.GC7747@mellanox.co.il>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 03 Jan 2005 15:39:57 -0800
In-Reply-To: <20050103233449.GC7747@mellanox.co.il> (Michael S. Tsirkin's
 message of "Tue, 4 Jan 2005 01:34:49 +0200")
Message-ID: <52zmzq5bg2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] Re: [2.6 patch] infiniband: possible cleanups
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 03 Jan 2005 23:39:57.0881 (UTC) FILETIME=[88DAF290:01C4F1ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Michael> By the way,
    Michael> http://linus.bkbits.net:8080/linux-2.5/ChangeSet@-2w?nav=index.html
    Michael> already has Roland's patches, and I thought that was what
    Michael> Linus uses for kernel releases, right, Roland?

Yes, the core kernel drivers are all merged in Linus's kernel
already.  Adrian and I are talking about modules that use some
currently unused APIs, such as Sean's madeye debugging module, the CM,
RMPP support, etc.

 - Roland

