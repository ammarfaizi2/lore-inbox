Return-Path: <linux-kernel-owner+w=401wt.eu-S1750788AbXAEV5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbXAEV5F (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 16:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbXAEV5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 16:57:05 -0500
Received: from rhlx01.hs-esslingen.de ([129.143.116.10]:51959 "EHLO
	rhlx01.hs-esslingen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788AbXAEV5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 16:57:04 -0500
X-Greylist: delayed 1188 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 16:57:03 EST
Date: Fri, 5 Jan 2007 22:37:13 +0100
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Robert Hancock <hancockr@shaw.ca>
Cc: indyszeto <indyszeto@yahoo.com.hk>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux Redhat 9.0 - SATA HDD compatibility
Message-ID: <20070105213713.GA13826@rhlx01.hs-esslingen.de>
References: <1167988994.999206.298700@s80g2000cwa.googlegroups.com> <459E5FE8.3080208@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459E5FE8.3080208@shaw.ca>
User-Agent: Mutt/1.4.2.2i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jan 05, 2007 at 08:25:44AM -0600, Robert Hancock wrote:
> indyszeto wrote:
> > I haven't done any partition or formatting work to this new SATA II HDD
> > since I bought it. Why RH9 couldn't detect the drive while BIOS could ?
> > Do I need to use more updated version of Redhat Linux to enable
> > installation on this SATA II HDD ?
> 
> Red Hat 9 had very little support for SATA controllers, it's way out of
> date now. You need a newer Linux distribution.

"very little support" seems excessively positive to me given that even RHEL3
(which, notwithstanding its progressing outdatedness, is incredibly more recent
than RH9) gained SATA support in its last update only (update 7),
IOW only RHEL4 has good SATA support (I'm not even sure whether its
initial release had it).

Why I know all this? Been there, done that... (piggybacked RHEL3 non-update-7
SATA install via Debian master boot)

So yes, RH9 is DEAD, especially when playing with SATA hardware, deal with it.

Andreas Mohr
