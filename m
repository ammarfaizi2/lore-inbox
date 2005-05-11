Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVEKSuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVEKSuX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 14:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEKSuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 14:50:23 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:12982 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262003AbVEKSuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 14:50:17 -0400
Date: Wed, 11 May 2005 19:50:15 +0100 (BST)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Karel Kulhavy <clock@twibright.com>
cc: James Simmons <jsimmons@pentafluge.infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: PC speaker input device
In-Reply-To: <20050511180722.GB8937@kestrel.twibright.com>
Message-ID: <Pine.LNX.4.56.0505111948320.1472@pentafluge.infradead.org>
References: <20050511153314.GA24815@kestrel> <Pine.LNX.4.56.0505111820200.32222@pentafluge.infradead.org>
 <20050511180722.GB8937@kestrel.twibright.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > > Hello
> > > 
> > > PC speaker (CONFIG_INPUT_PCSPKR) is in kernel make menuconfig
> > > 2.6.11-gentoo-r5 -> Device Drivers -> Input device support
> > > 
> > > PC speaker is output device. Why is output device in input device
> > > submenu? Isn't this a mistake?
> > 
> > Some keyboards have built in speakers. 
> 
> " Say Y here if you want the standard PC Speaker to be used for bells
>                              ^^^^^^^^^^^^^^^^^^^
> and whistles.  "
> 
> Nono, it is no keyboard built-in speaker, it's standard PC speaker.

For PCs this is true but take a look at the sun keyboards.

