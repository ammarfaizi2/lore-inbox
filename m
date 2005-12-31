Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbVLaD3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbVLaD3J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 22:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbVLaD3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 22:29:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:23979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932090AbVLaD3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 22:29:08 -0500
Date: Fri, 30 Dec 2005 19:28:49 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Jaco Kroon <jaco@kroon.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
Message-Id: <20051230192849.69e7cfbf.zaitcev@redhat.com>
In-Reply-To: <mailman.1135587661.17617.linux-kernel2news@redhat.com>
References: <43AF7724.8090302@kroon.co.za>
	<20051226082934.GD1844@elf.ucw.cz>
	<mailman.1135587661.17617.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.9; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Dec 2005 10:55:33 +0200, Jaco Kroon <jaco@kroon.co.za> wrote:

> Right, which clients is recommended for this type of work - mozilla is
> just not doing it for me any more.  I've heard some decent things about
> mutt, any other recomendations?

Mutt requires a terminal, which is not always convenient (e.g. the
copy-paste is not possible short of saving to a file, panels are infested
by similar icons). It is the ultimate text-mode client though.

I picked the Sylpheed from DaveM. It is unusually customizeable, for
a GUI client. It can corrupt patches if they have non-ASCII characters,
but that's something unavoidable, until the world switches to UTF-8
at least. Other than that, it has no discernable vices regarding
the whitespace mangling or line wrapping.

-- Pete
