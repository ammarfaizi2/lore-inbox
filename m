Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSCFTC0>; Wed, 6 Mar 2002 14:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293749AbSCFTCR>; Wed, 6 Mar 2002 14:02:17 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10749
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293722AbSCFTB5>; Wed, 6 Mar 2002 14:01:57 -0500
Date: Wed, 6 Mar 2002 11:02:49 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  March 6, 2002
Message-ID: <20020306190249.GB342@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C861CE4.6284.237C28E4@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C861CE4.6284.237C28E4@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> o in -ac      32bit UID quota support                         (?)
>

I'm surprised this is still pending, it's been in -ac for ages...

> o Beta        Fix long-held locks for low scheduling latency  (Andrew Morton, 
> etc.)

IIRC, LL isn't compatible with preempt, so maybe this item should be removed?

Also Andrew, where's the listing for the delayed allocation patch you're
working on.  It looks like it's just about ready to go to beta stage...

> o Alpha       Replace old NTFS driver with NTFS TNG driver    (Anton 
> Altaparmakov)

Is this still in alpha stage?

> o Alpha       Rewrite of the framebuffer layer                (James Simmons)
> o Started     Rewrite of the console layer                    (James Simmons)

Since this is in -dj and people are using it, maybe it should be beta?

