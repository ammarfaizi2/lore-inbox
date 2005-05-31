Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEaEqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEaEqn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 00:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVEaEqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 00:46:43 -0400
Received: from mail.timesys.com ([65.117.135.102]:12005 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S261194AbVEaEql convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 00:46:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Content-Class: urn:content-classes:message
Subject: RE: RT patch acceptance
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 31 May 2005 00:39:59 -0400
Message-ID: <3D848382FB72E249812901444C6BDB1D01588169@exchange.timesys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RT patch acceptance
thread-index: AcVla6WF55jLVdpTQ9KVW2W1GX6qzwALjZog
From: "Saksena, Manas" <Manas.Saksena@timesys.com>
To: <karim@opersys.com>, "Bill Huey (hui)" <bhuey@lnxw.com>
Cc: "Esben Nielsen" <simlo@phys.au.dk>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "kus Kusche Klaus" <kus@keba.com>, "James Bruce" <bruce@andrew.cmu.edu>,
       "Andi Kleen" <ak@muc.de>,
       "Sven-Thorsten Dietrich" <sdietrich@mvista.com>,
       "Ingo Molnar" <mingo@elte.hu>, <dwalker@mvista.com>,
       <hch@infradead.org>, <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote: 
> But wasn't the same said about the existing preemption code? Yet,
> most distros ship with it disabled and some developers still feel
> that there are no added benefits. What's the use if everyone is
> shipping kernels with the feature disabled? From a practical point of
> view, isn't it then obvious that such features catter for a minority?

That's a misrepresentation. It is well-known that Linux is used in 
a wide range of embedded devices. The embedded space is very fragmented,
with lots of home-grown Linux platforms. And, I would speculate that
many of them (as well as commercial distros catering to the embedded 
market) often enable preemption (including using non-mainlined kernel 
preemption patches for 2.4 kernels). 

Regards,
Manas
