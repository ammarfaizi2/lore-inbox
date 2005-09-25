Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbVIYHk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbVIYHk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Sep 2005 03:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVIYHk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Sep 2005 03:40:59 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:17461 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S1751232AbVIYHk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Sep 2005 03:40:58 -0400
Date: Sun, 25 Sep 2005 09:41:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: anup badhe <anup_223@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patching kgdb to linux
Message-ID: <20050925074133.GB7591@mars.ravnborg.org>
References: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050925035539.93945.qmail@web52407.mail.yahoo.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 24, 2005 at 08:55:39PM -0700, anup badhe wrote:
> i am trying to debug the linux kernel 2.6.10 using
> kgdb.i have downloaded the kgdb patch 2.6.10-mm2.bz2.
> after bunzip2 it gives me the file 2.6.10-mm2.
> 
> problem:
> 1- which type of file is this?
> 2- what patch command should i use(the options) so
> that i can patch it to linux 2.6.10.?
> 3-i have used the following command and it gives me
> some errors:

Search the archives for a tool named ketchup.
It allows you to do:
ketchup 2.6-mm

And after a cup of coffee or three you have a full kernel tree
available.

	Sam
