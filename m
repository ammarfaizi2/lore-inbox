Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262382AbREZBH1>; Fri, 25 May 2001 21:07:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262400AbREZBHR>; Fri, 25 May 2001 21:07:17 -0400
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:23300 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S262382AbREZBHD>; Fri, 25 May 2001 21:07:03 -0400
Date: Fri, 25 May 2001 19:06:58 -0600
From: Michal Jaegermann <michal@harddata.com>
To: Jay Thorne <Yohimbe@userfriendly.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Alpha SMP Low Outbound Bandwidth
Message-ID: <20010525190658.A7913@mail.harddata.com>
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <990827407.27355.2.camel@gracie.userfriendly.org>; from Yohimbe@userfriendly.org on Fri, May 25, 2001 at 02:50:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 25, 2001 at 02:50:07PM -0700, Jay Thorne wrote:
> [1.] One line summary of the problem:
> Kernel 2.4.4 ac15
....
> Using a quad 400Mhz Dodge/Rawhide machine with Tulip or VIARhine cards,
....
[ description of a slowdown skipped ].

Well, it looks that you have at least something to slow down.  I could
not get a single packet through my tulip on Alpha from at least
2.4.4-ac11 and up.  You can consider that an ultimate slowdown.  I tried
also a driver from http://sourceforge.net/projects/tulip/ and results
are the same.  This NIC, Digital DS21143 Tulip rev 65, works just fine
with various earlier kernels, including assorted 2.4.3 variants.
It is on 10baseT netwok - which may, or may not, be relevant here.

  Michal
