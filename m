Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266045AbTGIPKt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jul 2003 11:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268308AbTGIPKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jul 2003 11:10:49 -0400
Received: from main.gmane.org ([80.91.224.249]:38290 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266045AbTGIPKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jul 2003 11:10:47 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net
Subject: Re: Promise SATA 150 TX2 plus
Date: Wed, 09 Jul 2003 17:19:07 +0200
Message-ID: <yw1x1xwzwwwk.fsf@users.sourceforge.net>
References: <Pine.LNX.4.53.0307091413030.683@mx.homelinux.com> <027901c3461e$e023c670$401a71c3@izidor>
 <yw1xadbnx017.fsf@users.sourceforge.net>
 <20030709150852.GA11309@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:4gwOWhhy3bYNSgDuIKk9bWtZz2k=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

>> > Thanks for the answer, it has got PDC 20375, not
>> > 20376, but it changes nothing. As Alan mentioned
>> > here: http://marc.theaimsgroup.com/?l=linux-kernel&m=105440080221319&w=2
>> > promise has got their own drivers. Have somebody seen
>> > this drivers really working? My card is not RAID,
>> > its only controller, I want only see the harddrives.
>> 
>> Do yourself a favor, and get a Highpoint card instead.
>
> I can't speak to the highpoint card, I don't have one of those.  I do have
> a 3ware 8500-4 which works great.  I believe that I had to use a later
> kernel (2.4.20? .21?) to get it to work but it has been working flawlessly.
> I'm using it in RAID 10 mode.

The 3ware does real RAID, right?  I think the OP didn't need that.

-- 
Måns Rullgård
mru@users.sf.net

