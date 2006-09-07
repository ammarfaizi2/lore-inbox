Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751765AbWIGN6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbWIGN6k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 09:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbWIGN6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 09:58:39 -0400
Received: from smarthost2.sentex.ca ([205.211.164.50]:50408 "EHLO
	smarthost2.sentex.ca") by vger.kernel.org with ESMTP
	id S1751765AbWIGN6i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 09:58:38 -0400
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "'Chase Venters'" <chase.venters@clientec.com>,
       "'Krzysztof Halasa'" <khc@pm.waw.pl>
Cc: <ellis@spinics.net>, "'Willy Tarreau'" <w@1wt.eu>,
       <linux-kernel@vger.kernel.org>
Subject: RE: bogofilter ate 3/5
Date: Thu, 7 Sep 2006 09:58:11 -0400
Organization: Connect Tech Inc.
Message-ID: <086c01c6d285$a7ae9e40$294b82ce@stuartm>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
In-Reply-To: <Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: On Behalf Of Chase Venters
> You can check the From: or envelope sender against the subscriber 
> database. Forgery isn't a concern because we're not trying to stop 
> forgery with this method. Subscribers subscribing one address 

Forgery is always a concern...

> The perl script behaves as an optional autoresponder. 
> Autoresponders would 
> respond to spam as well (well, unless you put a spam filter 
> in front of 
> them, but I assume that many don't).

..because autoresponders are always replying to forged addresses:
http://www.spamcop.net/fom-serve/cache/329.html

> Also note that a number of people (myself included, at work 
> anyway) have 
> perl scripts that respond to all incoming mail and require a 
> reply cookie from original 
> envelope senders. We do it because it almost entirely 
> prevents spam from 
> arriving in our inboxes (I say almost because there is the occasional 

Autoresponder by another name, see above URL.

..Stu

