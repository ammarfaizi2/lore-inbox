Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263376AbTIWO7U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263378AbTIWO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:59:20 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:40651 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S263376AbTIWO7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:59:17 -0400
Subject: [OT] Re: ATTACK TO MY SYSTEM
From: Steven Cole <elenstev@mesatop.com>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Mike Galbraith <efault@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20030923134023.GA3032@werewolf.able.es>
References: <5.2.1.1.2.20030923114213.01b36e78@pop.gmx.net>
	 <20030923134023.GA3032@werewolf.able.es>
Content-Type: text/plain
Organization: 
Message-Id: <1064328224.1995.236.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 23 Sep 2003 08:43:44 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First, apologies to all since this is technically offtopic, but there
does seem to be enough interest in this subject that I'll provide a
short answer here.

On Tue, 2003-09-23 at 07:40, J.A. Magallon wrote:
> On 09.23, Mike Galbraith wrote:
> > At 11:12 AM 9/23/2003 +0200, german aracil boned wrote:
> > 
> > >Please
> > >
> > >I have an important attack in my system!
> > >I received many mails from many nets! with virus attachment.
> > >I don't have virus in my unix system. But people send mails with my mail
> > >address. Please see mail's header. It's not from my system ip.
> > >
> > >I close now my system to more of 700 nets!! and continuous receiving
> > >mails now :(:(:(
> > 
> > You aren't alone, I'm getting the same crap in my lkml account.  I'm using 
> > a pop previewer with filter to nuke it.  I don't know what else you can do 
> > about it other than to nuke the account, or hope that the ignorant twit 
> > who's doing this manages to irritate one of the network gods.
> > 
> 
> Me too.
> Some pointer to that pop previewer ?
> Filter based on attachments ?

The problem with the W32.Swen.A@mm worm/virus  became severe enough that
my home account on 56k dialup was almost unusable.  I've been getting
hundreds of these large emails per day for the past several days, and
the problem seems to be getting worse, not better.

At my home account, I've switched from Evolution to Kmail for my MUA. 
Under receiving options, you can select 'Filter messages if they are
greater than' some value you put in.  I've selected 40K, and this
results in a few false positives, but Kmail allows you to then select
each message individually to be received, stay on the pop server, or get
trashed. This is clearly suboptimal, but better than getting all that
junk.  It would be nice if 'getting trashed' was selectable as the
default, but that's a Kmail development issue.

Others have posted more elegant solutions using procmail.  Perhaps some
email gurus can put together a FAQ and post its URL. Thanks in advance
if you do.

Steven

