Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265426AbUFCBN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265426AbUFCBN0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 21:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265428AbUFCBN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 21:13:26 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:62437 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S265426AbUFCBNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 21:13:24 -0400
Date: Wed, 2 Jun 2004 18:12:53 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>, "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [announce] [patch] NX (No eXecute) support for x86, 2.6.7-rc2-bk2
Message-ID: <20040603011253.GD5953@ca-server1.us.oracle.com>
Mail-Followup-To: Arjan van de Ven <arjanv@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Andi Kleen <ak@suse.de>,
	"Siddha, Suresh B" <suresh.b.siddha@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>
References: <20040602205025.GA21555@elte.hu> <Pine.LNX.4.58.0406021411030.3403@ppc970.osdl.org> <20040602211714.GB29687@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602211714.GB29687@devserv.devel.redhat.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 11:17:14PM +0200, Arjan van de Ven wrote:
> On Wed, Jun 02, 2004 at 02:13:13PM -0700, Linus Torvalds wrote:
> > Just out of interest - how many legacy apps are broken by this? I assume 
> > it's a non-zero number, but wouldn't mind to be happily surprised.
> 
> based on execshield in FC1.. about zero.

	Doesn't Sun's JDK break here?

Joel

-- 

"Maybe the time has drawn the faces I recall.
 But things in this life change very slowly,
 If they ever change at all."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
