Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWIGWVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWIGWVi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932174AbWIGWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:21:38 -0400
Received: from smarthost1.sentex.ca ([64.7.153.18]:27378 "EHLO
	smarthost1.sentex.ca") by vger.kernel.org with ESMTP
	id S932166AbWIGWVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:21:36 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Chase Venters'" <chase.venters@clientec.com>
Cc: "'Krzysztof Halasa'" <khc@pm.waw.pl>, <ellis@spinics.net>,
       "'Willy Tarreau'" <w@1wt.eu>, <linux-kernel@vger.kernel.org>
Subject: RE: [OT] RE: bogofilter ate 3/5
Date: Thu, 7 Sep 2006 18:21:06 -0400
Organization: Connect Tech Inc.
Message-ID: <08f301c6d2cb$ea2cdac0$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.64.0609071604010.31500@turbotaz.ourhouse>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chase Venters [mailto:chase.venters@clientec.com] 
> So what is the SpamCop RBL data used for then?

SpamCop uses it on their own mail service to flag messages as
potential spam and filter those out to a junk folder.

They also publish the list publicly.

So, SpamCop is blocking 0 emails.

As for third parties looking at their RBL, SpamCop specifically
recommends that the list *not* be used for blocking:
http://www.spamcop.net/fom-serve/cache/291.html

> (1) The mail _would_ be solicited because you asked for it on 
> my behalf;

So you'll be sending me your snail mail address then? Thanks.

> permission. Phony permission, perhaps, but permission nonetheless...

False permission is no permission at all. That's a widely recognised
concept; in law, life and the internet.

> On Thu, 7 Sep 2006, Stuart MacDonald wrote:
> > Things change.
> 
> Yes, and eventually Internet mail will grow up and forgery 

SMTP is growing up *right now*. The reconfig of servers to not send
unsolicted bounces/etc is part of the growing-up-ness.

The following fall into two categories:

> 1. No more bounce messages
> 4. No more deferral messages

Servers can be configed to not send these. To those whose systems are
set up in such a manner to require accepting the message before
delivery, to paraphrase Chase, "(2) Spammers would be responsible for
your misery, not the parties rejecting your bounces".

> 2. No more "Your message has been queued for moderator 
> approval" messages
> 3. No more "Thanks for contacting CrapCo, your support ticket 
> # is 238417" 
> messages
> 5. No more vacation mail
> 6. No more challenge/response systems
> 7. No more mailing lists that you can sign up to by sending mail to 
> subscribe@list.org or majordomo@list.org; all subscription and 
> unsubscription must be done through web interfaces

All of these should be sent by a human.

> can turn all auto-response systems off completely.

Yep. That's the growing up you were looking for earlier.

It looks like we disagree on the method of change required. That's
life.

..Stu

