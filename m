Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVCFLZf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVCFLZf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 06:25:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261376AbVCFLZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 06:25:35 -0500
Received: from rgminet04.oracle.com ([148.87.122.33]:33601 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S261375AbVCFLZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 06:25:29 -0500
Date: Sun, 6 Mar 2005 03:20:07 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Greg KH <greg@kroah.com>
Cc: Chris Wright <chrisw@osdl.org>, torvalds@osdl.org,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Message-ID: <20050306112007.GR27331@ca-server1.us.oracle.com>
Mail-Followup-To: Greg KH <greg@kroah.com>, Chris Wright <chrisw@osdl.org>,
	torvalds@osdl.org, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050304222146.GA1686@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050304222146.GA1686@kroah.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6+20040907i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2005 at 02:21:46PM -0800, Greg KH wrote:
> Anything else anyone can think of?  Any objections to any of these?

	Well, Linus's rules regarding signoff are good as well.  I'd
suggest, once there is a set of $sucker-evaluators, we could use a good
rule like requiring 5 folks to signoff (Linus's original proposal), or
3 including the subsystem maintainer (who doesn't have to be part of
$sucker-evaluators) - whichever comes first.  Any patch that affects an
area where it isn't easy to determine who is the authorative maintainer
just has to wait for the full 5 person signoff.

Joel


-- 

"Behind every successful man there's a lot of unsuccessful years."
        - Bob Brown

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
