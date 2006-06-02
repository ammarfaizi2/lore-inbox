Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWFBIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWFBIxi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWFBIxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:53:37 -0400
Received: from ccerelbas01.cce.hp.com ([161.114.21.104]:5761 "EHLO
	ccerelbas01.cce.hp.com") by vger.kernel.org with ESMTP
	id S1751338AbWFBIxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:53:37 -0400
Date: Fri, 2 Jun 2006 14:23:33 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@hp.com>
To: Martin Bligh <mbligh@mbligh.org>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       "Martin J. Bligh" <mbligh@google.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       apw@shadowen.org
Subject: Re: 2.6.17-rc5-mm1
Message-ID: <20060602085333.GA26068@satan.india.hp.com>
References: <fa.OzJugEVv9WJAu9OjbsckjHU7X1U@ifi.uio.no> <fa.Gc0Mz2XRYv0MekBhe0EU0fxdjxI@ifi.uio.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa.Gc0Mz2XRYv0MekBhe0EU0fxdjxI@ifi.uio.no>
User-Agent: mutt-ng/devel-r782 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2006 at 04:55:49PM +0000, Martin Bligh wrote:
> Roman Zippel wrote:
> >Hi,
> >On Thu, 1 Jun 2006, Martin J. Bligh wrote:
> >>Did you read the discussion that lead up to it? I thought that quite
> >>clearly described why such a thing was needed.
> >I did read it, what did I miss?
> 
> So the point is to enable the performance-affecting debug options by
> default, but provide one clear hook to turn them all off, with a name
> that's consistent over time, so we can do it in an automated fashion.
> 

How about using mechanism similar to smp alternatives to enable disable these 
features /debug options run time ?

-aneesh
