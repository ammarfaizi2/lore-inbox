Return-Path: <linux-kernel-owner+w=401wt.eu-S964928AbXASOTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbXASOTO (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 09:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964934AbXASOTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 09:19:14 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:50171 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964928AbXASOTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 09:19:13 -0500
X-Originating-Ip: 74.109.98.130
Date: Fri, 19 Jan 2007 09:00:38 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@CPE00045a9c397f-CM001225dbafb6
To: Andreas Schwab <schwab@suse.de>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: can someone explain "inline" once and for all?
In-Reply-To: <jeejprnmns.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.64.0701190858300.25621@CPE00045a9c397f-CM001225dbafb6>
References: <Pine.LNX.4.64.0701190645400.24224@CPE00045a9c397f-CM001225dbafb6>
 <jefya7jfxi.fsf@sykes.suse.de> <Pine.LNX.4.64.0701190846480.25561@CPE00045a9c397f-CM001225dbafb6>
 <jeejprnmns.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Andreas Schwab wrote:

> "Robert P. J. Day" <rpjday@mindspring.com> writes:
>
> > but in terms of strict C89 compatibility, it would seem to be a bit
> > late for that given:
> >
> >   $ grep -r "static inline " .
> >
> > no?
>
> The kernel does not use strict C89, it uses GNUC89.

  in that case, why did you just waste my time and all that bandwidth
by writing in your previous post:

"... so you need to use a different spelling when you want to stay
compatible with strict C89."

  please do me a favour and don't post another reply until you go back
and actually read my original question.

rday
