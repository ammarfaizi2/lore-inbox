Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262543AbTGCNMS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 09:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262577AbTGCNMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 09:12:18 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:52675 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262543AbTGCNMS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 09:12:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Sean Neakums <sneakums@zork.net>, Andrew Morton <akpm@osdl.org>
Subject: Re: o1-interactivity.patch (was Re: 2.5.74-mm1)
Date: Thu, 3 Jul 2003 23:30:42 +1000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20030703023714.55d13934.akpm@osdl.org> <6u65mjkayg.fsf@zork.zork.net>
In-Reply-To: <6u65mjkayg.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307032330.42311.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jul 2003 23:15, Sean Neakums wrote:
> Andrew Morton <akpm@osdl.org> writes:
> > . Included Con's CPU scheduler changes.  Feedback on the effectiveness of
> >   this and the usual benchmarks would be interesting.
>
> I find that this patch makes X really choppy when Mozilla Firebird is
> loading a page (which it does through an ssh tunnel here).  Both the X
> pointer and the spinner in the tab that is loading stop and start, for
> up to a second at a time.

Thanks for the feedback. I know about and am working on this one. No mention 
of the rest of the performance?

Con

