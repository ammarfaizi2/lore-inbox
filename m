Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422681AbWBNRRn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422681AbWBNRRn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422689AbWBNRRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:17:43 -0500
Received: from smtp102.sbc.mail.mud.yahoo.com ([68.142.198.201]:9897 "HELO
	smtp102.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1422681AbWBNRRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:17:42 -0500
From: David Brownell <david-b@pacbell.net>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Tue, 14 Feb 2006 09:04:37 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <200602131116.41964.david-b@pacbell.net> <200602131910.50304.david-b@pacbell.net> <43F1733E.8010300@cfl.rr.com>
In-Reply-To: <43F1733E.8010300@cfl.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200602140904.38305.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 10:05 pm, Phillip Susi wrote:
> David Brownell wrote:
> > No, not "AFAIK" ... since when I told you explicitly that was untrue,
> > you then ignored that statement.  And didn't look at the specs that
> > I pointed you towards, which provide the details.  (USB 2.0 spec re
> > hubs; and of course the Linux-USB hub driver ... www.usb.org)
> 
> I ignored nothing.  I fully accepted your explanation as true and 
> pointed out that it changes nothing;

Sorry, I still can't see a way to read your response to me in that way.
When I said "X", you said "AFAIK, X is false".  More than once in the
same post ... e.g. you say "all hardware must be re-probed", I said "all
is wrong" and provided a common counterexample with USB, then you still
said "all/AFAIK".  And then tried to switch to another topic (see below).
I don't have time to waste on such non-dialogue.

> data loss in this perfectly valid  
> use case just because the kernel can not be absolutely certain the user 
> did not do something stupid while suspended is unacceptable.

Odd, data loss wasn't even mentioned in any of the comments of yours
to which I was responding.  I was providing corrections to what you
were writing about suspend-to-RAM cases.

- Dave
