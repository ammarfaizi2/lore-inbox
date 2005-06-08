Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVFHQXd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVFHQXd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbVFHQV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:21:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:32339 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S261374AbVFHQU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:20:58 -0400
Date: Wed, 08 Jun 2005 12:20:57 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Linux v2.6.12-rc6
In-reply-to: <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
X-X-Sender: nico@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Message-id: <Pine.LNX.4.63.0506081216110.5370@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org>
 <20050607130535.GD16602@harddisk-recovery.com>
 <Pine.LNX.4.58.0506070820170.2286@ppc970.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2005, Linus Torvalds wrote:

> (Btw, Jeff, I think the git-shortlog script is slightly buggered, it
> doesn't do the nice word-wrap, and it _only_ takes the first line, even
> from a multi-line header. I think it should stop at the first empty line
> in the commit, not just take the first one).

Also if the lists of commits could be shown in chronological order (like 
the bk shortlog script did) that would be nice.  Right now the list is 
reversed.


Nicolas
