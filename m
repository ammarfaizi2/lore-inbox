Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269099AbUJQKW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269099AbUJQKW2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 06:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269100AbUJQKW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 06:22:28 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:2769 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269099AbUJQKW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 06:22:26 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org, wwolf@vt.edu
Subject: Re: AMD64 Swsusp on 2.6.9-rc4-mm1
Date: Sun, 17 Oct 2004 12:24:14 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>
References: <417188EA.4090205@vt.edu> <200410162252.33347.rjw@sisk.pl> <1100589554.7496.2.camel@Xnix>
In-Reply-To: <1100589554.7496.2.camel@Xnix>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410171224.14434.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 of November 2004 08:19, William Wolf wrote:
> Is this supposedly something new in rc4-mm1?  I have been having the
> same problems since around 2.6.8.1, though i havent gone through every
> single -mm patch, i have tried at least one in every -rcx candidate, and
> they have all done this same thing.

This may be for another reason.  I generally test all of the -rc and -mm 
patches on an AMD64 box and apparently 2.6.9-rc4-mm1 is the first one that 
has the problem I was talking about.  AFAICT, the other kernels may fail in a 
similar way if memory is stuffed with something (eg after updatedb).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
