Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSHIRnS>; Fri, 9 Aug 2002 13:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315370AbSHIRnS>; Fri, 9 Aug 2002 13:43:18 -0400
Received: from 209-166-240-202.cust.walrus.com.240.166.209.in-addr.arpa ([209.166.240.202]:27365
	"EHLO ti3.telemetry-investments.com") by vger.kernel.org with ESMTP
	id <S315265AbSHIRnQ>; Fri, 9 Aug 2002 13:43:16 -0400
Date: Fri, 9 Aug 2002 13:46:47 -0400
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Daniel Phillips <phillips@arcor.de>,
       frankeh@watson.ibm.com, davidm@hpl.hp.com,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, gh@us.ibm.com,
       Martin.Bligh@us.ibm.com, William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: large page patch (fwd) (fwd)
Message-ID: <20020809134647.A19270@ti19>
References: <Pine.LNX.4.44L.0208091317220.23404-100000@imladris.surriel.com> <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.44.0208090951570.1436-100000@home.transmeta.com>; from torvalds@transmeta.com on Fri, Aug 09, 2002 at 09:52:53AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 09:52:53AM -0700, Linus Torvalds wrote:
> Read up on positivism.

Please don't.  Read Karl Popper instead.
 
> "If it can't be measured, it doesn't exist".
 
The positivist Copenhagen interpretation stifled important areas of
physics for half a century.  There is a distinction to be made between
an explanatory construct (whereby I mean to imply nothing fancy, no
quarks, just a brick), and the evidence that supports that construct
in the form of observable quantities.  It's all there in Popper's work.

> The point being that there are things we can measure, and until anything 
> else comes around, those are the things that will have to guide us.

True, as far as it goes.  Measurement=good, idle-speculation=bad.
 
But it pays to keep in mind that progress is nonlinear.  In 1988, Van
Jabobsen noted (http://www.kohala.com/start/vanj.88jul20.txt):

   (I had one test case that went like
 
       Basic system:    600 KB/s
       add feature A:    520 KB/s
       drop A, add B:    530 KB/s
       add both A & B:    700 KB/s
 
   Obviously, any statement of the form "feature A/B is good/bad"
   is bogus.)  But, in spite of the ambiguity, some of the network
   design folklore I've heard seems to be clearly wrong.
 
Such anomalies abound.

Regards,

   Bill Rugolsky
