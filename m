Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292383AbSBPPgm>; Sat, 16 Feb 2002 10:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292394AbSBPPgc>; Sat, 16 Feb 2002 10:36:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45060 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292383AbSBPPgX>;
	Sat, 16 Feb 2002 10:36:23 -0500
Message-ID: <3C6E7C75.A6659D72@mandrakesoft.com>
Date: Sat, 16 Feb 2002 10:36:21 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de> <3C6DE87C.FA96D1D6@mandrakesoft.com> <20020216095202.M23546@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com>:
> > Impacting kernel developers' productivity and workflow because of this
> > is more of what I object to...
> 
> I still don't get why you think CML2 is going to interfere with your
> workflow.  Would you explain this to me, please?

(please read "CML2 feedback" message before this...)

Ideally in the future I can add and update a driver's makefile and
configuration information by patching drivers/net/netdriver.c and
drivers/net/netdriver.conf, and touch absolutely no other files.

	Jeff



-- 
Jeff Garzik      | "Why is it that attractive girls like you
Building 1024    |  always seem to have a boyfriend?"
MandrakeSoft     | "Because I'm a nympho that owns a brewery?"
                 |             - BBC TV show "Coupling"
