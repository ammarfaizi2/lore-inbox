Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262218AbUJZLAU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262218AbUJZLAU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbUJZLAU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:00:20 -0400
Received: from zamok.crans.org ([138.231.136.6]:13956 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S262218AbUJZLAQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:00:16 -0400
To: Christophe Saout <christophe@saout.de>
Cc: linux-kernel@vger.kernel.org, Alasdair G Kergon <agk@redhat.com>
Subject: Re: 2.6.9-mm1: LVM stopped working
References: <87oeitdogw.fsf@barad-dur.crans.org>
	<1098731002.14877.3.camel@leto.cs.pocnet.net>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Tue, 26 Oct 2004 13:00:13 +0200
In-Reply-To: <1098731002.14877.3.camel@leto.cs.pocnet.net> (Christophe Saout's
	message of "Mon, 25 Oct 2004 21:03:22 +0200")
Message-ID: <87lldt7nia.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout <christophe@saout.de> disait dernièrement que :

> Are you encrypting your PV or your LVs?
>
> There's some new dm-crypt code in -mm1 along with some API changes, but
> backward compatibility is provided and should work.

I tried 2.6.9-mm1, reverting all the new dm-crypt stuff, and it didn't make it.
So it is not related to these patches.
Will look further into it later; for now I must go working on my PhD :)

Best regards,

-- 
<riel> google rules
<google> rules: http://www.law.cornell.edu/rules/fre/overview.html

	- Rik van Riel chatting with the bots on #kernelnewbies

