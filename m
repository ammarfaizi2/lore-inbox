Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932305AbWAQSQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932305AbWAQSQx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 13:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbWAQSQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 13:16:53 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:5390 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932305AbWAQSQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 13:16:52 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: mkrufky@m1k.net
Subject: Re: [KORG] GITWEB doesn't show any DIFF's
Date: Tue, 17 Jan 2006 18:17:00 +0000
User-Agent: KMail/1.9
Cc: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@gmail.com>
References: <43CCF8BB.1050009@m1k.net> <200601171739.17168.s0348365@sms.ed.ac.uk> <43CD309A.3030704@m1k.net>
In-Reply-To: <43CD309A.3030704@m1k.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601171817.00182.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 17:59, Michael Krufky wrote:
[snip]
> >>
> >>... I have tried this at multiple locations, using several different
> >>browsers under different OS's ... It won't show me a diff no matter what
> >>I do, and it USED to work (about a week ago)
> >>
> >>I'm surprised nobody has complained about this already.  (or maybe I
> >>just didnt see any such thread about it)
> >
> >Seems to work for me right _now_, could you verify that this is still
> >happening?
>
> I confirm, that nothing has changed...... Once again, no matter what OS,
> no matter what browser, no matter which location I am sitting at, I see
> no diff.

Try holding shift and pressing refresh. Maybe it's some bizarre caching issue?

Also, try s/www/zeus2/ in the URL to see if it's a problem specific to one 
server (I wonder if the reason some of us have problems and others don't is 
that we are being http load balanced).

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
