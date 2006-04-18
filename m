Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbWDSABQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbWDSABQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 20:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750881AbWDSABQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 20:01:16 -0400
Received: from sccrmhc12.comcast.net ([63.240.77.82]:13807 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750877AbWDSABP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 20:01:15 -0400
From: Dan Dennedy <dan@dennedy.org>
To: Jody McIntyre <scjody@modernduck.com>
Subject: Re: [RFC: 2.6 patch] the overdue removal of RAW1394_REQ_ISO_{LISTEN,SEND}
Date: Tue, 18 Apr 2006 16:59:28 -0700
User-Agent: KMail/1.9.1
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>,
       linux1394-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
References: <20060406224706.GD7118@stusta.de> <443814AA.1040707@s5r6.in-berlin.de> <20060418094540.GO5346@conscoop.ottawa.on.ca>
In-Reply-To: <20060418094540.GO5346@conscoop.ottawa.on.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604181659.28416.dan@dennedy.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 April 2006 2:45 am, Jody McIntyre wrote:
> On Sat, Apr 08, 2006 at 09:53:14PM +0200, Stefan Richter wrote:
> > We should have added such warnings already to the kernel at the moment
> > when the two ioctls went into feature-removal-schedule.txt.
>
> We originally decided just to put it into libraw1394.  I don't see the
> point of having it in two places, but I suppose it couldn't hurt.. I'll
> take a patch :)

The compile warnings were put into libraw1394 repo a while ago, but there was 
not a release containing them until about a week ago. 
-- 
+-DRD-+
