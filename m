Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSGUEje>; Sun, 21 Jul 2002 00:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317637AbSGUEje>; Sun, 21 Jul 2002 00:39:34 -0400
Received: from web12905.mail.yahoo.com ([216.136.174.72]:45587 "HELO
	web12905.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S317541AbSGUEjd>; Sun, 21 Jul 2002 00:39:33 -0400
Message-ID: <20020721044238.70210.qmail@web12905.mail.yahoo.com>
Date: Sat, 20 Jul 2002 21:42:38 -0700 (PDT)
From: Tom Walcott <thomaswalcott@yahoo.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 21, 2002  01:24 +0100, Alan Cox wrote:
> On Sat, 2002-07-20 at 22:24, Andreas Dilger wrote:
> > I, for one, would like to have the choice to use
the AIX LVM format, and
> > I'm sure that people thinking of migrating from
HP/UX or whatever would
> > want to be able to add support for their on-disk
LVM format.  It really
> > provides a framework to consolidate all of the
partition/MD code into
> > a single place (e.g. RAID, LVM, LDM (windows NT),
DOS, BSD, Sun, etc).
> 
> The LVM format for AIX and so on call all be handled
by LVM2

Can LVM2 currently do everything that EVMS does? From
looking at this, it appears there is a difference.
http://evms.sourceforge.net/comparison.pdf

-Tom

__________________________________________________
Do You Yahoo!?
Yahoo! Health - Feel better, live better
http://health.yahoo.com
