Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132572AbRDQGli>; Tue, 17 Apr 2001 02:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132569AbRDQGl3>; Tue, 17 Apr 2001 02:41:29 -0400
Received: from m308-mp1-cvx1c.col.ntl.com ([213.104.77.52]:35741 "EHLO
	[213.104.77.52]") by vger.kernel.org with ESMTP id <S132565AbRDQGlO>;
	Tue, 17 Apr 2001 02:41:14 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE843@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 17 Apr 2001 07:40:36 +0100
In-Reply-To: "Grover, Andrew"'s message of "Mon, 16 Apr 2001 16:32:49 -0700"
Message-ID: <m2pueckp0b.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Grover, Andrew" <andrew.grover@intel.com> writes:

> > From: Pavel Machek [mailto:pavel@suse.cz]
> > There are 32 signals, and signals can carry more information, if
> > required. I really think doing it way UPS-es are done is right
> > approach.

> I would think that it would make sense to keep shutdown with all the
> other power management events. Perhaps it will makes more sense to
> handle UPS's through the power management code.

I'm happy add UPS functionality to the pmpolicy patch, if someone were
willing to test it - as I have no UPS ;-)

[...]

-- 

	http://www.penguinpowered.com/~vii
