Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275266AbTHMP5W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 11:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275268AbTHMP5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 11:57:22 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:24257 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S275266AbTHMP5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 11:57:19 -0400
Date: Thu, 14 Aug 2003 01:54:50 +1000
From: CaT <cat@zip.com.au>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org, kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813155449.GA488@zip.com.au>
References: <20030812020226.GA4688@zip.com.au> <1060654733.684.267.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1060654733.684.267.camel@localhost>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 07:18:53PM -0700, Robert Love wrote:
> On Mon, 2003-08-11 at 19:02, CaT wrote:
> > Is there any interest ins omeone 'fixing up' as many structs in the
> > kernel from the form:
> 
> Yes, indeed, especially for 2.6. There has been a lot of work already in
> this direction -- not too much should be left.

Cool. Since noone screamed 'OH FOR THE LOVE OF GOD, NO!' I'll do it (or
at least try to :) Should hopefully have something by the weekend. :)

> > And if so, what form should I feed it back in? Big patches? 1 patch
> > per file? 1 per dir?
> 
> Whatever makes most sense. One per directory is probably OK for most
> things.

Cool.

-- 
"How can I not love the Americans? They helped me with a flat tire the
other day," he said.
	- http://tinyurl.com/h6fo
