Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129381AbRDWQBp>; Mon, 23 Apr 2001 12:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131407AbRDWQBe>; Mon, 23 Apr 2001 12:01:34 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:33208 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S131382AbRDWQBU>;
	Mon, 23 Apr 2001 12:01:20 -0400
Message-ID: <3AE451C6.619F32F8@mandrakesoft.com>
Date: Mon, 23 Apr 2001 12:01:10 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: rjd@xyzzy.clara.co.uk
Cc: linux-kernel@vger.kernel.org, Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Subject: Re: New driver for FarSite synchronous cards
In-Reply-To: <200104231021.f3NAL7P22306@xyzzy.clara.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rjd@xyzzy.clara.co.uk wrote:
> 
> Hi,
> 
> I've just completed the first draft of a new device driver for the FarSite
> Communications, FarSync T2P and T4P cards.  These cards are intelligent
> synchronous serial cards supporting 2 or 4 ports running at up to 8Mbps with
> X.21, V.35 or V.24 signalling.
> 
> This mail is basically a call for testers and reviewers, and a plea to find
> the overall maintainer for WAN card drivers.

This is from linux/MAINTAINERS:
WAN ROUTER & SANGOMA WANPIPE DRIVERS & API (X.25, FRAME RELAY, PPP,
CISCO HDLC)
P:     Nenad Corbic
M:     ncorbic@sangoma.com
M:     dm@sangoma.com
W:     http://www.sangoma.com
S:     Supported

The "& API" may apply to you.  Also Krzysztof Halasa (cc'd) has played
WAN maintainer role as well.

-- 
Jeff Garzik      | The difference between America and England is that
Building 1024    | the English think 100 miles is a long distance and
MandrakeSoft     | the Americans think 100 years is a long time.
                 |      (random fortune)
