Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932454AbVIKIzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932454AbVIKIzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 04:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbVIKIzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 04:55:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18651 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932454AbVIKIzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 04:55:23 -0400
To: Meelis Roos <mroos@linux.ee>
Cc: "Brown, Len" <len.brown@intel.com>, Pierre Ossman <drzeus-list@drzeus.cx>,
       acpi-devel@lists.sourceforge.net, ncunningham@cyclades.com,
       Pavel Machek <pavel@ucw.cz>, Masoud Sharbiani <masouds@masoud.ir>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: reboot vs poweroff
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8DAF@hdsmsx401.amr.corp.intel.com>
	<m1d5ngk4xa.fsf@ebiederm.dsl.xmission.com>
	<Pine.SOC.4.61.0509111140550.9218@math.ut.ee>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 11 Sep 2005 02:53:39 -0600
In-Reply-To: <Pine.SOC.4.61.0509111140550.9218@math.ut.ee> (Meelis Roos's
 message of "Sun, 11 Sep 2005 11:43:04 +0300 (EEST)")
Message-ID: <m1psrghtnw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> writes:

>> OK hopefully this is my final version of this bug fix.
>
> I'm not in the position to test threse patches any more because the mainboard in
> question died last week when I installed some more RAM into it. Masoud Sharbiani
> <masouds@masoud.ir> added to CC: since he experienced the same problem.

Thanks for looking.

At this point I am less worried about fixing the bug.  Then I am
worried about the form of the bug fix.  (i.e. do weird compile
options break it).

But any testing or review is appreciated.

Eric

