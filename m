Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262012AbVCIQAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262012AbVCIQAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 11:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261639AbVCIQAP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 11:00:15 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:10734 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S261652AbVCIP53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 10:57:29 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH][3/3] swsusp: use non-contiguous memory
Date: Wed, 9 Mar 2005 17:00:01 +0100
User-Agent: KMail/1.7.1
Cc: hugang@soulinfo.com, linux-kernel@vger.kernel.org
References: <200503042051.54176.rjw@sisk.pl> <200503081247.51797.rjw@sisk.pl> <200503081300.08594.rjw@sisk.pl>
In-Reply-To: <200503081300.08594.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503091700.02389.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tuesday, 8 of March 2005 13:00, Rafael J. Wysocki wrote:
]-- snip --[ 
> > > Now, akpm sent all (?) swsusp updates to Linus, so it should appear in
> > > bk tree later today. If you could regenerate the patches (1/3 will no
> > > longer be needed) and send them to me & l-k. I'll then forward them to
> > > akpm. [He seems to prefer patches to come from my email address :-)]
> > 
> > OK
> > 
> > Here's the 2/3 one (ie the main resume part).  Do you need the summary?
> 
> Here's the 3/3 one (ie the ppc support from hugang).
> 
> The patches are against 2.6.11 + 1/3 (ie suspend part), but they should
> apply cleanly to the -bk w/ the suspend part as well.

FYI, 2.6.11-kb5 is out and it contains the "suspend" patch.  The patches that
I have sent you apply to it cleanly.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
