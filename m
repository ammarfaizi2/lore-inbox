Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVEYC2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVEYC2I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVEYC2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:28:07 -0400
Received: from opersys.com ([64.40.108.71]:10254 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262240AbVEYC1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:27:50 -0400
Message-ID: <4293E4ED.7030804@opersys.com>
Date: Tue, 24 May 2005 22:37:33 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Daniel Walker <dwalker@mvista.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, sdietrich@mvista.com
Subject: Re: RT patch acceptance
References: <1116890066.13086.61.camel@dhcp153.mvista.com> <20050524054722.GA6160@infradead.org> <20050524064522.GA9385@elte.hu> <4292DFC3.3060108@yahoo.com.au> <20050524081517.GA22205@elte.hu> <4292E559.3080302@yahoo.com.au> <20050524090240.GA13129@elte.hu> <4292F074.7010104@yahoo.com.au> <1116957953.31174.37.camel@dhcp153.mvista.com> <20050524224157.GA17781@nietzsche.lynx.com>
In-Reply-To: <20050524224157.GA17781@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> I think there's a lot of general ignorance regarding this patch, the
> usefulness of it and this thread is partially addressing them.

Forgive the dumb question:
Why isn't anyone doing a presentation about Ingo's patch at the OLS
this year?

If you want to get this thing in front of peoples' eyes, this would
probably be the best venue. It would certainly be a good place to
get people talking about it. Explaining what's in the patch, how
it came to be, what are the interdependencies, modifications to
existing code, added core files, pros/cons, performance, actual
demo, etc.

Currently, looking at the listed presentations, apart from finding
myself thinking "hm..., I swear that guy did the same presentation
last year ... and maybe the year before", I can't see any entry
alluding to rt-preempt ... maybe I missed it?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
