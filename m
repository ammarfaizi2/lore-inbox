Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317633AbSGJVhn>; Wed, 10 Jul 2002 17:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317634AbSGJVhm>; Wed, 10 Jul 2002 17:37:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46346 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317633AbSGJVhm>;
	Wed, 10 Jul 2002 17:37:42 -0400
Message-ID: <3D2CA958.BEE16D98@zip.com.au>
Date: Wed, 10 Jul 2002 14:38:32 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
       Linux <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
References: <59885C5E3098D511AD690002A5072D3C02AB7F88@orsmsx111.jf.intel.com> <3D2CA6E3.CB5BC420@zip.com.au> <20020710173555.D2005@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> 
> On Wed, Jul 10, 2002 at 02:28:03PM -0700, Andrew Morton wrote:
> > > But on the other hand, increasing HZ has perf/latency benefits, yes? Have
> > > these been quantified?
> >
> > Not that I'm aware of.  And I'd regard any such claims with some
> > scepticism.
> 
> The most obvious one is the reduced latency of select/poll timeouts.

OK, I'll grant that.  Why is this useful?

-
