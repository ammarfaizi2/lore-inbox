Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266821AbUJNVaE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266821AbUJNVaE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267212AbUJNV33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:29:29 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29658 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266821AbUJNVXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:23:53 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Spam on the list
Date: Thu, 14 Oct 2004 23:25:31 +0200
User-Agent: KMail/1.6.2
Cc: Norbert van Nobelen <Norbert@edusupport.nl>
References: <416EA06E.3050608@colannino.org> <Pine.LNX.4.53.0410141201470.7694@chaos.analogic.com> <200410142041.33694.Norbert@edusupport.nl>
In-Reply-To: <200410142041.33694.Norbert@edusupport.nl>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200410142325.31972.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 of October 2004 20:41, Norbert van Nobelen wrote:
> Can't we run it through spamassassin with a whitelist for the real users on 
> the list, and standard filters for the new users. With keeping track of the 
> pointsscore they will be auto whitelisted if they are not spammers.

I'd rather not like _legitimate_ messages being filtered out as 
false-positives.  You can always run spamassassin locally with any rules you 
like and feed the LKML traffic to it before it gets to your mailbox.

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
