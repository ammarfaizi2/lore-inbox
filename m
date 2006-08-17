Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932204AbWHQJJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932204AbWHQJJr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 05:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWHQJJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 05:09:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48584 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932204AbWHQJJr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 05:09:47 -0400
Subject: Re: GPL Violation?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Anonymous User <anonymouslinuxuser@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
References: <40d80630608162248y498cb970r97a14c582fd663e1@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Aug 2006 10:30:37 +0100
Message-Id: <1155807037.15195.50.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 22:48 -0700, ysgrifennodd Anonymous User:
> I suspect the company will try to get away with releasing as little as
> possible.  I don't know much about the GPL or Linux kernel internals,
> but I want to encourage the company I work for to give back to the
> community.

You should read the GPL license (its fairly plain English). Any matters
of doubt should be discussed with someone qualified to discuss then
(such as a lawyer).

In terms of general policy
- The GPL requires you make source available to your customers by one of
several means (mail in, zip archive on the CD with the manual etc). It
is considered "polite" to also make the changes available publically on
the web somewhere as well.
- There are bodies such as the CE Linux Forum that may be useful to you
and the company.

> I understand that modifications to GPL code must be released under the
> GPL.  So if they tweak a scheduler implementation, this must be
> released.  What if a new driver is written to support a custom piece
> of hardware?  Yes, the driver was written to work with the Linux
> kernel, but it isn't based off any existing piece of code.

Basically if it is a derivative work (see your lawyer). This is a
non-trivial area of law so really you should ask your lawyer not a bunch
of programmers.

Alan
--
        "Some people are like Slinkies...
        Not really good for anything,
        but they still bring a smile to your face
        when you push them down a flight of stairs."
                        -- Gordon Wolfe.

