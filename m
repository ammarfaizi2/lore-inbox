Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757090AbWKVWyO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757090AbWKVWyO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 17:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757092AbWKVWyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 17:54:14 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:7142 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1757087AbWKVWyO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 17:54:14 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 4/4] swsusp: Fix labels
Date: Wed, 22 Nov 2006 23:50:18 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@linuxmail.org>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200611182335.27453.rjw@sisk.pl> <200611190025.06860.rjw@sisk.pl> <20061122143241.6b1a34ac.randy.dunlap@oracle.com>
In-Reply-To: <20061122143241.6b1a34ac.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611222350.19243.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 22 November 2006 23:32, Randy Dunlap wrote:
> On Sun, 19 Nov 2006 00:25:06 +0100 Rafael J. Wysocki wrote:
> 
> > On Sunday, 19 November 2006 00:06, Nigel Cunningham wrote:
> > > Hi.
> > > 
> > > On Sat, 2006-11-18 at 23:51 +0100, Rafael J. Wysocki wrote:
> > > > Move all labels in the swsusp code to the second column, so that they won't
> > > > fool diff -p.
> > > 
> > > This sounds like working around brokenness in diff -p. Should/could a
> > > patch be submitted to the diff maintainer instead?
> > 
> > No.  This feature of diff is actually documented.
> > 
> > There was a discussion on LKML about it some time ago and the patch follows
> > the conclusion.
> 
> There was discussion, and then both Jesper and I tried to
> reproduce the problem with diff and could not do so.
> Maybe it has already been fixed. (?)

Well, I'm not sure.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
