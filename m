Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVE3Wy4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVE3Wy4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVE3Wyx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 18:54:53 -0400
Received: from opersys.com ([64.40.108.71]:40207 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261811AbVE3WyK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 18:54:10 -0400
Message-ID: <429B9BDB.1020705@opersys.com>
Date: Mon, 30 May 2005 19:03:55 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: "Bill Huey (hui)" <bhuey@lnxw.com>
CC: Esben Nielsen <simlo@phys.au.dk>, James Bruce <bruce@andrew.cmu.edu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@muc.de>,
       Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org,
       Philippe Gerum <rpm@xenomai.org>
Subject: Re: RT patch acceptance
References: <Pine.OSF.4.05.10505302040560.31148-100000@da410.phys.au.dk> <429B6D14.2070206@opersys.com> <20050530224504.GD9972@nietzsche.lynx.com>
In-Reply-To: <20050530224504.GD9972@nietzsche.lynx.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bill Huey (hui) wrote:
> I've always like your project and the track that it has taken with the
> above along with the scheduler work. I am surprised that more folks don't
> use it, but I think that has to do with the sucky web site and inability
> for me and others to navigate through it for proper information.

<sarcasm-not-worth-responding-to>
Sucky web site without proper info ... hmm ... any chances you can point
me to the website for PREEMPT_RT, surely the professional design of it
and the included documentation will make me want to adopt it right away
... what's that you say, there's no website ...
</sarcasm-not-worth-responding-to>

:) seriously, though, I can't believe we've discouraged you because
we're very poor at website design. Surely after all that's been said
about the nanokernel approach you'd want to at least dedicate some
short amount of time for downloading the code and at least running
a diffstat on it or something ... or even better, giving it a test
ride. Philippe has even gone as far as providing patches providing
both PREEMPT_RT and Adeos under the same roof ... it doesn't get
much better than that ...

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
