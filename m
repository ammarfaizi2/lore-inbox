Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266738AbUFYV2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266738AbUFYV2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 17:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266863AbUFYV2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 17:28:00 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:59801 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S266738AbUFYV16 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 17:27:58 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Sean Neakums <sneakums@zork.net>, linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
Date: Fri, 25 Jun 2004 23:36:50 +0200
User-Agent: KMail/1.5
References: <40DB605D.6000409@comcast.net> <200406252252.47266.rjwysocki@sisk.pl> <6u8yeb1hwc.fsf@zork.zork.net>
In-Reply-To: <6u8yeb1hwc.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406252336.50522.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 of June 2004 22:50, Sean Neakums wrote:
> "R. J. Wysocki" <rjwysocki@sisk.pl> writes:
> > I think that the good reason for keeping both ext* code bases in the
> > kernel tree is that _there_ _are_ _some_ people who will need ext2 for
> > some purposes, so why should we pull the carpet from under them?
>
> An ext3 that supports no-journal operation can surely register itself
> as both ext2 and ext3 and leave userspace none the wiser.
>
> I don't think anybody wants to pull any carpets out from under anyone.

Sorry, I've been too offensive.

IMO, if ext2 is kept separate, the development of it may be focused on 
different user needs than the development of ext3 is focused on.  It's worth 
doing as long as there's someone who will prefer ext2 to ext3 and someone 
who's interested in working on ext2 itself.  That's my point.

Yours,
rjw

----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
