Return-Path: <linux-kernel-owner+w=401wt.eu-S1751534AbXAVHJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbXAVHJ2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 22 Jan 2007 02:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751854AbXAVHJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Jan 2007 02:09:28 -0500
Received: from thunk.org ([69.25.196.29]:41798 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751556AbXAVHJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Jan 2007 02:09:27 -0500
To: linux-kernel@vger.kernel.org, ksummit-2006-discuss@thunk.org
Subject: 2007 Linux Kernel Summit
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1H8tIr-0006QH-Bg@candygram.thunk.org>
Date: Mon, 22 Jan 2007 02:09:17 -0500
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi folks,

	It's time to start kicking off the 2007 Kernel Summit planning
process.  This year, the Kernel Summit will be held in Cambridge,
England, at the DeVere University Arms Hotel, September 5-6 (with a
welcome reception on the 4th).  The decision to move the Kernel Summit
to England is a one-year experiment based on the very strong request of
last year's kernel summit attendees to try a location outside of Ottawa,
and especially from the roughly 1/3rd of the attendees that come from
the UK or Europe.  So the plan is for us to book the Ottawa Congress
Ceter space for July 2008 (which we will need to do by mid-year 2007),
and pending how well the Cambridge venue works out in September 2007,
we'll figure out how often we want to try moving the Kernel Summit to
other locations in future years beyond 2008.  

(It'd be great to fantasize pairing the Kernel Summit with
Linux.conf.au, but unless we can get some sponsor's CEO offers up their
personal jet, or we pick up a major airline as a sponsor, it's not
likely to happen any time soon due to the reality of corporate travel
budgets.  :-)

As in previous years, I've set up a e-mail discussion list for people
who are interested in making suggestions for this year's kernel summit.
In the probably hopeless attempt to avoid the list address getting
instantly harvested by spammers from all of the LKML archives, the list
submission address and subscription URL can be found by executing the
following perl script:

#!/usr/bin/perl
$at="@"; 
$AD=(gmtime(time))[5]+1900;
print "ksummit-" . $AD . "-discuss" . $at . "thunk.org\n";
print "http://thunk.org/mailman/listinfo/ksummit-" . $AD . "-discuss\n";

More announcements about the topic and attendee selection process will
be made in the next week or so on the discuss list, but in the meantime,
if there are any folks who are interested in putting together
mini-summits or workshops for various kernel subsystems at Ottawa on the
25th or 26th, please let me know.  It may be possible for Usenix to make
some hotel conference rooms available, to provide an opportunity for
kernel development teams who want to get together before OLS and the
Kernel Summit to do so.

Finally, let me introduce to this year's program committee:

	Jens Axboe
	James Bottomley
	Jonathon Corbet
	Dirk Hohndel
	Gerrit Huizenga
	Dave Jones
	Andi Kleen
	Greg Kroah-Hartman
	Steve Hemminger	
	Matthew Mackall
	Andrew Morton
	Theodore Ts'o

If you have any questions, please feel to contact me or the entire
kernel summit program committee.  Our contact e-mail address can be
found by taking the output from the above perl script and running it
through the command: "sed -e 's/discuss/pc/'".

Regards,

						- Ted
