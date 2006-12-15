Return-Path: <linux-kernel-owner+w=401wt.eu-S965052AbWLOVMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965052AbWLOVMK (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 16:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965055AbWLOVMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 16:12:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:59357 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965052AbWLOVMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 16:12:09 -0500
Subject: Re: 2.6.18 mmap hangs unrelated apps
From: Arjan van de Ven <arjan@infradead.org>
To: Michal Sabala <lkml@saahbs.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061215210642.GI6220@prosiaczek>
References: <20061215023014.GC2721@prosiaczek>
	 <1166199855.5761.34.camel@lade.trondhjem.org>
	 <20061215175030.GG6220@prosiaczek>
	 <1166211884.5761.49.camel@lade.trondhjem.org>
	 <20061215210642.GI6220@prosiaczek>
Content-Type: text/plain
Organization: Intel International BV
Date: Fri, 15 Dec 2006 22:12:06 +0100
Message-Id: <1166217126.3365.230.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> I do not have any indication that it is the server not responding. Other
> applications which have NFS files open are continuing to work while in
> this case XFree86 blocks.

just a strange question, but which video driver do you use in X? maybe
that one is blocking say the pci bus or something...


