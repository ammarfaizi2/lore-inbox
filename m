Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268296AbTGIOyi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 10:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268297AbTGIOyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 10:54:38 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:30891 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S268296AbTGIOya
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 10:54:30 -0400
Date: Wed, 9 Jul 2003 08:08:52 -0700
From: Larry McVoy <lm@bitmover.com>
To: mru@users.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA 150 TX2 plus
Message-ID: <20030709150852.GA11309@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	mru@users.sourceforge.net, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor> <yw1xadbnx017.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xadbnx017.fsf@users.sourceforge.net>
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=0.5,
	required 7, AWL, DATE_IN_PAST_06_12)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 09, 2003 at 04:11:32PM +0200, mru@users.sourceforge.net wrote:
> "Milan Roubal" <roubm9am@barbora.ms.mff.cuni.cz> writes:
> 
> > Thanks for the answer, it has got PDC 20375, not
> > 20376, but it changes nothing. As Alan mentioned
> > here: http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
> > promise has got their own drivers. Have somebody seen
> > this drivers really working? My card is not RAID,
> > its only controller, I want only see the harddrives.
> 
> Do yourself a favor, and get a Highpoint card instead.

I can't speak to the highpoint card, I don't have one of those.  I do have
a 3ware 8500-4 which works great.  I believe that I had to use a later
kernel (2.4.20? .21?) to get it to work but it has been working flawlessly.
I'm using it in RAID 10 mode.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
