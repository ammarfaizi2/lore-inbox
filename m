Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268136AbTBNVFX>; Fri, 14 Feb 2003 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268061AbTBNVDe>; Fri, 14 Feb 2003 16:03:34 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:49613 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S268049AbTBNVDI>; Fri, 14 Feb 2003 16:03:08 -0500
Date: Fri, 14 Feb 2003 13:12:49 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Rusty Lynch <rusty@linux.co.intel.com>, Matt Porter <porter@cox.net>,
       Scott Murray <scottm@somanetworks.com>,
       Patrick Mochel <mochel@osdl.org>, Dave Jones <davej@codemonkey.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] Proposal for a new watchdog interface using sysfs
Message-ID: <20030214211249.GD30804@ca-server1.us.oracle.com>
References: <Pine.LNX.4.33.0302131317210.1133-100000@localhost.localdomain> <Pine.LNX.4.44.0302131603500.23407-100000@rancor.yyz.somanetworks.com> <20030213155817.B1738@home.com> <1045173941.1009.4.camel@vmhack> <1045183679.1009.7.camel@vmhack> <1045234137.7958.17.camel@irongate.swansea.linux.org.uk> <1045236757.12974.14.camel@vmhack> <1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045245352.1353.35.camel@irongate.swansea.linux.org.uk>
X-Burt-Line: Trees are cool.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2003 at 05:55:53PM +0000, Alan Cox wrote:
> think you need to care about that for now. Sysfs doesn't help here in
> the general case as it lacks persistant file permissions, but where it

	Oh, junk.  I liked this proposal a lot, but lack of persistent
permissions kills it pretty dead.

Joel


-- 

Life's Little Instruction Book #182

	"Be romantic."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
