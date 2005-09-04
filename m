Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750774AbVIDBJq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750774AbVIDBJq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 21:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVIDBJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 21:09:46 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:33529 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S1750717AbVIDBJp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 21:09:45 -0400
Date: Sat, 3 Sep 2005 18:09:12 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: linux clustering <linux-cluster@redhat.com>
Cc: Wim Coekaerts <wim.coekaerts@oracle.com>, akpm@osdl.org,
       linux-fsdevel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904010912.GJ8684@ca-server1.us.oracle.com>
Mail-Followup-To: linux clustering <linux-cluster@redhat.com>,
	Wim Coekaerts <wim.coekaerts@oracle.com>, akpm@osdl.org,
	linux-fsdevel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509030242.36506.phillips@istop.com> <20050903064633.GB4593@ca-server1.us.oracle.com> <200509031821.27070.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509031821.27070.phillips@istop.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 03, 2005 at 06:21:26PM -0400, Daniel Phillips wrote:
> that fit the configfs-nee-sysfs model?  If it does, the payoff will be about 
> 500 lines saved.

	I'm still awaiting your merge of ext3 and reiserfs, because you
can save probably 500 lines having a filesystem that can create reiser
and ext3 files at the same time.

Joel

-- 

Life's Little Instruction Book #267

	"Lie on your back and look at the stars."

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

