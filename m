Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWIFU5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWIFU5A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 16:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWIFU5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 16:57:00 -0400
Received: from khc.piap.pl ([195.187.100.11]:462 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751425AbWIFU46 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 16:56:58 -0400
To: Chase Venters <chase.venters@clientec.com>
Cc: ellis@spinics.net, w@1wt.eu (Willy Tarreau), linux-kernel@vger.kernel.org
Subject: Re: bogofilter ate 3/5
References: <200609061856.k86IuS61017253@no.spam>
	<Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 06 Sep 2006 22:56:55 +0200
In-Reply-To: <Pine.LNX.4.64.0609061409360.18840@turbotaz.ourhouse> (Chase Venters's message of "Wed, 6 Sep 2006 14:15:46 -0500 (CDT)")
Message-ID: <m34pvkvhm0.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters <chase.venters@clientec.com> writes:

> 1. Incoming mail from subscribers is accepted

How do you know if the sender is really a subscriber?

> 4. A handy Perl script subscribes to lkml, and for any message it gets
> with an X-Bogofilter: SPAM header, it sends a notification
> (rate-limited) to the message sender

How do you know who the sender really is? IMHO bouncing anything
(especially spam) after SMTP OK is worse than the spam itself.
-- 
Krzysztof Halasa
