Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269295AbUJQVne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269295AbUJQVne (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 17:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269296AbUJQVnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 17:43:31 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:10914 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S269295AbUJQVn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 17:43:29 -0400
Subject: Re: 2.6.9-rc2-mm1 swsusp bug report.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jan Rychter <jan@rychter.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041017191031.GA7476@elf.ucw.cz>
References: <2HO0C-4xh-29@gated-at.bofh.it> <2I5b2-88s-15@gated-at.bofh.it>
	 <2I5E5-6h-19@gated-at.bofh.it> <2I7Zd-1TK-11@gated-at.bofh.it>
	 <E1CB10O-0000HL-FJ@localhost> <20040925101640.GB4039@elf.ucw.cz>
	 <m2zn2uigka.fsf@tnuctip.rychter.com>
	 <20041011133234.GA16217@atrey.karlin.mff.cuni.cz>
	 <m2hdp1gvbq.fsf@tnuctip.rychter.com>  <20041017191031.GA7476@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1098049218.3489.9.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Mon, 18 Oct 2004 07:40:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, 2004-10-18 at 05:10, Pavel Machek wrote:
> You can have code that does not panic, does not crash, does not
> corrupt your data, never fails to suspend and is in Linus' tree.
> 
> ...no, that is too good. It sounds like a fairy tale.
> 
> So pick any four.
> 								Pavel
> 
> PS: And it is real. We have conflicting goals here and I consider
> "refuses to suspend" least critical.

I'm going for all five! You're probably right, nevertheless. I can't say
suspend2 _never_ fails to suspend. It's just very rare.

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

