Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbULTPp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbULTPp3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 10:45:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbULTPmC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 10:42:02 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24557 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261543AbULTPkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 10:40:24 -0500
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arne Caspari <arnem@informatik.uni-bremen.de>
Cc: Arjan van de Ven <arjan@infradead.org>,
       linux1394-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041220132012.GA6046@localhost>
References: <20041220015320.GO21288@stusta.de>
	 <41C694E0.8010609@informatik.uni-bremen.de>
	 <1103544944.4133.7.camel@laptopd505.fenrus.org>
	 <20041220132012.GA6046@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103553354.30268.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Dec 2004 14:35:58 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-20 at 13:20, Arne Caspari wrote:
> > are you going to submit that driver for inclusion any time soon ?
> 
> What would be the benefit if I do so? I have no access to linux1394 SVN or kernel repositories so I can only support the version on sourceforge. 

Everyone can submit patches to the kernel tree. If your driver is open
source and you and your customers would benefit from having it just work
out of the box with distributions please consider submitting it. It also
helps maintainability because it becomes obvious when something will
break your driver and people can code accordingly (or submit fixes that
also fix up your driver code).

Alan

