Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135263AbRDWOqV>; Mon, 23 Apr 2001 10:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135264AbRDWOqL>; Mon, 23 Apr 2001 10:46:11 -0400
Received: from office.mandrakesoft.com ([195.68.114.34]:29942 "HELO
	giants.mandrakesoft.com") by vger.kernel.org with SMTP
	id <S135263AbRDWOp7>; Mon, 23 Apr 2001 10:45:59 -0400
To: Michael J Clark <clarkmic@pobox.upenn.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: P4 problem with 2.4.3
In-Reply-To: <200104231442.f3NEg3m05750@pobox.upenn.edu>
From: Chmouel Boudjnah <chmouel@mandrakesoft.com>
Date: 23 Apr 2001 16:44:30 +0100
In-Reply-To: <200104231442.f3NEg3m05750@pobox.upenn.edu> (Michael J Clark's message of "Mon, 23 Apr 2001 10:42:03 -0400 (EDT)")
Message-ID: <m37l0bzkm9.fsf@giants.mandrakesoft.com>
User-Agent: Gnus/5.090002 (Oort Gnus v0.02) Emacs/21.0.100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael J Clark <clarkmic@pobox.upenn.edu> writes:

> I believe APIC is enabled, it does some kind of check for it.  Everything 
> is pretty much default.  I read that the APIC can cause interrupt 
> problems,  should I disable it?  If so, is that done in the kernel config?

yes APIC cause problems for me on a PIV, you should disable it in the config...

-- 
MandrakeSoft Inc                     http://www.chmouel.org
                      --Chmouel
