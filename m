Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263631AbTFDQ7g (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 12:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263638AbTFDQ7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 12:59:36 -0400
Received: from mta8-svc.business.ntl.com ([62.253.164.48]:56030 "EHLO
	mta8-svc.business.ntl.com") by vger.kernel.org with ESMTP
	id S263631AbTFDQ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 12:59:33 -0400
Date: Wed, 4 Jun 2003 18:15:01 +0100 (BST)
From: William Gallafent <william.gallafent@virgin.net>
X-X-Sender: williamg@officebedroom.oldvicarage
To: LKML <linux-kernel@vger.kernel.org>
Cc: joe briggs <jbriggs@briggsmedia.com>
Subject: OT: Re: impact of Athlon's slower front-side-bus (FSB)
In-Reply-To: <1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.53.0306041807180.1785@officebedroom.oldvicarage>
References: <200306020947.44520.jbriggs@briggsmedia.com>
 <1054565258.7494.34.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jun 2003, Alan Cox wrote:

> On Llu, 2003-06-02 at 14:47, joe briggs wrote:
> > The fastest AMD single processor Athlon XP is 3200 with 400 Mhz FSB.
> > The fastest AMD dual processor Athlon MP is 2800 but with only 266 Mhz FSB.
> >
> > So, for a multimedia application, which platform would be faster?  How does
> > the much slower FSB of the dual processor impact its ability to grab and
> > crunch.  Does its onboard cache make the slower speed FSB less important?
>
> Its really hard to tell. The 3200 has a bigger cache too if I remember
> rightly.

Yes, 512KB vs 256KB. The top "Barton" MP (2800+?) also has 512KB L2 onboard,
and uses the same core as the top Athlon XPs, but sticks to 266MHz FSB since
this is what's supported by 760MP(X) chipset.
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26426.PDF

-- 
Bill Gallafent.
