Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbTJQTwY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJQTwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:52:24 -0400
Received: from main.gmane.org ([80.91.224.249]:18078 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263599AbTJQTwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:52:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Software RAID5 with 2.6.0-test
Date: Fri, 17 Oct 2003 21:52:17 +0200
Message-ID: <yw1xd6cvk5fy.fsf@users.sourceforge.net>
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com>
 <yw1xu167kbcw.fsf@users.sourceforge.net> <3F903768.7060803@rackable.com>
 <yw1xllrjk70f.fsf@users.sourceforge.net>
 <20031017193756.GH8711@unthought.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:ixjF7cWyHHalMnlcROr115lXSWA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob Oestergaard <jakob@unthought.net> writes:

>> >    many clock cycles availble to it.  It's even worse when you realize
>> >    the 2Ghz xeon is a better proccessor in many more ways than just
>> >    clock cycles.
>> 
>> How about this logic:
>> 
>> 1) If the processor on the RAID controller can handle the full
>> bandwidth of the disks, it's fast enough.
>> 2) If someone else does the 10% work, the CPU can do 10% more work.
>
> 3) You have a four year old machine - one day the RAID controller dies.
>    The company that produced it has been acquired by someone else, and
>    the product is no longer availble.  Can you get a new adapter with
>    firmware that can actually read your disks?   Or are your data lost?
>    Can you find a replacement controller on e-bay?  And would you want
>    to?

What are backups for?  That argument applies to any controller, for
anything.  What if you wanted to read those old 8" floppies?  Or that
hard disk from the PDP/11.

If a four year old RAID controller breaks, maybe it's time to get new
disks anyway.

-- 
Måns Rullgård
mru@users.sf.net

