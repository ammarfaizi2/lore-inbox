Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbULTNUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbULTNUv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 08:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbULTNUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 08:20:51 -0500
Received: from imh.informatik.uni-bremen.de ([134.102.224.4]:27280 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S261503AbULTNUr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 08:20:47 -0500
Date: Mon, 20 Dec 2004 14:20:12 +0100
From: Arne Caspari <arnem@informatik.uni-bremen.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Arne Caspari <arnem@informatik.uni-bremen.de>,
       linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
Message-ID: <20041220132012.GA6046@localhost>
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <1103544944.4133.7.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103544944.4133.7.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reply to the mail from Arjan van de Ven (arjan@infradead.org):

> On Mon, 2004-12-20 at 10:01 +0100, Arne Caspari wrote:
> > Adrian,
> > 
> > Some of these symbols are used by the open source driver "video-2-1394" 
> > ( http://sourceforge.net/projects/video-2-1394 ).
> 
> 
> are you going to submit that driver for inclusion any time soon ?

What would be the benefit if I do so? I have no access to linux1394 SVN or kernel repositories so I can only support the version on sourceforge. 

 -Arne

