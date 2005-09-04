Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750965AbVIDEab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbVIDEab (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 00:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750995AbVIDEab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 00:30:31 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:57546 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S1750854AbVIDEaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 00:30:30 -0400
Date: Sat, 3 Sep 2005 21:30:00 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904043000.GQ8684@ca-server1.us.oracle.com>
Mail-Followup-To: Daniel Phillips <phillips@istop.com>,
	Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <20050903183241.1acca6c9.akpm@osdl.org> <20050904030640.GL8684@ca-server1.us.oracle.com> <200509040022.37102.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509040022.37102.phillips@istop.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 12:22:36AM -0400, Daniel Phillips wrote:
> It is 640 lines.

	It's 450 without comments and blank lines.  Please, don't tell
me that comments to help understanding are bloat.

> I said "configfs" in the email to which you are replying.

To wit:

> Daniel Phillips said:
> > Mark Fasheh said:
> > > as far as userspace dlm apis go, dlmfs already abstracts away a
> > > large
> > > part of the dlm interaction...
> >
> > Dumb question, why can't you use sysfs for this instead of rolling
> > your
> > own?

	You asked why dlmfs can't go into sysfs, and I responded.

Joel

-- 

"I don't want to achieve immortality through my work; I want to
 achieve immortality through not dying."
        - Woody Allen

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

