Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262307AbVDXKrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262307AbVDXKrR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 06:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262306AbVDXKpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 06:45:50 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:24746 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262307AbVDXKp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 06:45:28 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] swsusp: misc cleanups [3/4]
Date: Sun, 24 Apr 2005 12:41:55 +0200
User-Agent: KMail/1.7.1
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200504232320.54477.rjw@sisk.pl> <200504232334.17343.rjw@sisk.pl> <20050423221826.GE1884@elf.ucw.cz>
In-Reply-To: <20050423221826.GE1884@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200504241241.55411.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, 24 of April 2005 00:18, Pavel Machek wrote:
> Hi!
> 
> > The following patch cleans up whitespace in swsusp.c (a bit):
> > - removes any trailing whitespace
> > - adds spaces after if, for, for_each_pbe, for_each_zone etc., wherever
> > necessary.
> > 
> > Please consider for applying.
> 
> Few hunks rejected, so I just applied those that work.

Sorry.  I did my best to be careful about this one, but without much success,
apparently.

> This is the result....

Fine,

Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

