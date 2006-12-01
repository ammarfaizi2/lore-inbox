Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031602AbWLAQuR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031602AbWLAQuR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031608AbWLAQuR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:50:17 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:23987 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1031605AbWLAQuP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:50:15 -0500
Date: Fri, 1 Dec 2006 16:56:38 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Ben Collins <ben.collins@ubuntu.com>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] [x86] Add command line option to enable/disable
 hyper-threading.
Message-ID: <20061201165638.7d5f1c4e@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0612010815510.3695@woody.osdl.org>
References: <11648607683157-git-send-email-bcollins@ubuntu.com>
	<11648607733630-git-send-email-bcollins@ubuntu.com>
	<20061201132918.GB4239@ucw.cz>
	<1164980500.5257.922.camel@gullible>
	<1164983529.3233.73.camel@laptopd505.fenrus.org>
	<1164985757.5257.933.camel@gullible>
	<1164989436.3233.85.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.64.0612010815510.3695@woody.osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I think people have blown those SSL timing attacks _way_ out of 
> proportion, just because it sounds technical and cool. 
> 
> Besides, most of the time you can disable HT in the BIOS, which is better 
> anyway if you don't want it.

Agreed - but the SSL thing is an irrelevance. The main reason for
disabling HT (especially on a single core CPU) is because a lot of
workloads run faster with HT *off*.

Alan
