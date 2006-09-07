Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWIGLzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWIGLzg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbWIGLzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:55:36 -0400
Received: from khc.piap.pl ([195.187.100.11]:37853 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751481AbWIGLzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:55:36 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: ellis@spinics.net, w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
References: <200609061856.k86IuS61017253@no.spam>
	<Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
	<m34pvkvhm0.fsf@defiant.localdomain>
	<Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 07 Sep 2006 13:55:33 +0200
In-Reply-To: <Pine.LNX.4.64.0609061658440.18840@turbotaz.ourhouse> (Chase Venters's message of "Wed, 6 Sep 2006 17:05:05 -0500 (CDT)")
Message-ID: <m37j0fvqkq.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

> You can check the From: or envelope sender against the subscriber
> database. Forgery isn't a concern because we're not trying to stop
> forgery with this method.

That's the first problem.

> The perl script behaves as an optional autoresponder. Autoresponders
> would respond to spam as well (well, unless you put a spam filter in
> front of them, but I assume that many don't).

Yep. Sending their "responses" to innocent people, instead of spam
senders. That's what many "antivirus" do.

> Also note that a number of people (myself included, at work anyway)
> have perl scripts that respond to all incoming mail and require a
> reply cookie from original envelope senders. We do it because it
> almost entirely prevents spam from arriving in our inboxes

Sure. Don't you think is also prevents a lot of legitimate mail?
Hope that all addresses you send mail to are automatically added
to a white list? (I'm especially annoyed with people asking me for
something, and then my answer bounces with "click somewhere"
response).
-- 
Krzysztof Halasa
