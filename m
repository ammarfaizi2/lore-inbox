Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932232AbWJEV4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932232AbWJEV4A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932307AbWJEV4A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:56:00 -0400
Received: from ackle.nomi.cz ([81.31.33.35]:32216 "EHLO ackle.nomi.cz")
	by vger.kernel.org with ESMTP id S932232AbWJEVz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:55:59 -0400
Date: Thu, 5 Oct 2006 23:55:55 +0200
From: onovy@nomi.cz
To: linux-kernel@vger.kernel.org
Subject: Re: ip_conntrack_core - possible memory leak in 2.4
Message-ID: <20061005215555.GA11253@nomi.cz>
Reply-To: linux-kernel@vger.kernel.org
References: <20061004180201.GA18386@nomi.cz> <20061005193028.GC5050@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005193028.GC5050@1wt.eu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Well, I know several old 2.4 netfilter systems running around and which
> process between 100 and 200 millions of sessions a day with peak hours
> around 4000 sessions/s. They might have been rebooted twice in 3 years,
> and they still work without a glitch. So I clearly don't think that the
> problem mentionned above is present in plain 2.4. It might be a very
> old bug in you rather old kernel, or one specific to some patches in
> your distro's kernel (BTW, I would be surprized you wouldn't find
> anything more recent than 2.4.17).
If you look at that link, you will see man with same problem as i have at
2.4.26 kernel. I'm just trying to do some diffs and collect some more
information. I can't switch kernel in that device, because i'm not author of
that firmware.

-- 
S pozdravem/Best regards
 Ondrej Novy
 
Email: onovy@nomi.cz
Jabber: onovy@njs.netlab.cz
ICQ: 115-674-713
MSN: onovy@hotmail.com
Yahoo ID: novy_ondrej
Tel/Cell: +420 777 963 207
