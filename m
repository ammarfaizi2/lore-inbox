Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137157AbREKPUL>; Fri, 11 May 2001 11:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137156AbREKPUB>; Fri, 11 May 2001 11:20:01 -0400
Received: from patan.Sun.COM ([192.18.98.43]:1247 "EHLO patan.sun.com")
	by vger.kernel.org with ESMTP id <S137154AbREKPTx>;
	Fri, 11 May 2001 11:19:53 -0400
Message-ID: <3AFC0340.EC7F6F98@canada.sun.com>
Date: Fri, 11 May 2001 11:20:32 -0400
From: David Collier-Brown <davecb@canada.sun.com>
Organization: Priv ate Person
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
CC: "Andrew M. Theurer" <atheurer@austin.ibm.com>,
        Mike Kravetz <mkravetz@sequent.com>, lse-tech@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@samba.org>
Subject: Re: [Lse-tech] Re: Linux 2.4 Scalability, Samba, and Netbench
In-Reply-To: <3AF97062.42465A53@austin.ibm.com> <20010509095658.B1150@w-mikek2.sequent.com> <3AF97EBB.9F0ABE9A@austin.ibm.com> <20010510141050.D928@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 09, 2001 at 11:29:22AM -0500, Andrew M. Theurer wrote:
> I am evaluating Linux 2.4 SMP scalability, using Netbench(r) as a
> workload with Samba, and I wanted to get some feedback on results so
> far.

	Also consider using Andrew Tridgell's 
	dbench/tbench/smbtorture suite in this process: it
	is mathmeatically comparable to NetBench, runs on
	smaller numbers of load-generationg machines, and
	can give better breakdowns into the disk component,
	then network component and the on-server component
	of the available performance.

	I also have some results from SPARC Linux: send me email.

--dave
-- 
David Collier-Brown,           | Always do right. This will gratify 
Performance & Engineering Team | some people and astonish the rest.
Americas Customer Engineering  |                      -- Mark Twain
(905) 415-2849                 | davecb@canada.sun.com
