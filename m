Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129704AbRA0Kua>; Sat, 27 Jan 2001 05:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130388AbRA0KuU>; Sat, 27 Jan 2001 05:50:20 -0500
Received: from [194.213.32.137] ([194.213.32.137]:24580 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S129704AbRA0KuH>;
	Sat, 27 Jan 2001 05:50:07 -0500
Message-ID: <20010126181835.A136@bug.ucw.cz>
Date: Fri, 26 Jan 2001 18:18:35 +0100
From: Pavel Machek <pavel@suse.cz>
To: LA Walsh <law@sgi.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 cpu usage...
In-Reply-To: <NBBBJGOOMDFADJDGDCPHMEDDCKAA.law@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <NBBBJGOOMDFADJDGDCPHMEDDCKAA.law@sgi.com>; from LA Walsh on Tue, Jan 23, 2001 at 12:32:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> So...I'm bummed.  I'm assuming a 30% degradation in an app is probably
> not expected behavior?  Swap usage is '0' in both OS's (i.e. it's not
> a run out of memory issue).

Vmware is _not_ application, it is dirty kernel hack. Do it without
vmware.
								Pavel

-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
