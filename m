Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261976AbTIMAz1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 20:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261978AbTIMAz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 20:55:27 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:26007 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261976AbTIMAz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 20:55:26 -0400
From: Cort Dougan <cort@ftsoj.fsmlabs.com>
Date: Fri, 12 Sep 2003 18:55:37 -0600
To: Judith Lebzelter <judith@osdl.org>, linux-kernel@vger.kernel.org,
       plm-devel@lists.sourceforge.net
Subject: Re: PowerPC Cross-compile of 2.6 kernels
Message-ID: <20030913005537.GA767@ftsoj.fsmlabs.com>
References: <20030912165635.GJ13672@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.33.0309121042310.29740-100000@osdlab.pdx.osdl.net> <20030912213243.GB22885@ip68-0-152-218.tc.ph.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030912213243.GB22885@ip68-0-152-218.tc.ph.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be nice to see the 4xx and 8xx chips being tested.  There are a
lot of rarely tested configurations and targets in the PPC kernel.

} > > > > > In response to requests at OLS, we've added cross-compile
} > > > > > capability to the PLM, and the first architecture
} > > > > > implemented is PowerPC.  The powerpc code is
} > > > > > generated via a cross-compiler set up using Dan
} > > > > > Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
} > > > > > glibc-2.3.2 and built for the powerpc-750.
} > > > > >
} > > > > > The filter run is the compile regress developed by John
} > > > > > Cherry at OSDL.  Refer to his prior mail on lkml for the
} > > > > > results of this filter on ia386 and IA64.
} > > > > >
} > > > > > Look at
} > > > > >     http://www.osdl.org/plm-cgi/plm?module=search
} > > > > > and look up linux-2.6.0-test5 or any later kernels for the
} > > > > > results of this filter under 'PPC-Cross Compile Regress'.
} > > > > >
} > > > > > Does anyone have any input regarding requests for
} > > > > > additional architectures or improvements to the
} > > > > > filters?  Please cc me in any responses to lkml as I do
} > > > > > not currently monitor this list, though other OSDL
} > > > > > employees do.
