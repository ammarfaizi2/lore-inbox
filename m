Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269981AbTHCJGe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:06:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270256AbTHCJGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:06:34 -0400
Received: from pdbn-d9bb864b.pool.mediaWays.net ([217.187.134.75]:16394 "EHLO
	citd.de") by vger.kernel.org with ESMTP id S269981AbTHCJGd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:06:33 -0400
Date: Sun, 3 Aug 2003 11:06:27 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: linux-kernel@vger.kernel.org
Subject: Re: System locks up hard when i delete a file while burning a DVD-R (seems reiserfs related)
Message-ID: <20030803090627.GA5958@citd.de>
References: <Pine.LNX.4.44.0308021930440.2741-100000@korben.citd.de> <20030802181529.GA3038@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802181529.GA3038@citd.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 08:15:29PM +0200, Matthias Schniedermeyer wrote:
> On Sat, Aug 02, 2003 at 07:45:40PM +0200, Matthias Schniedermeyer wrote:
> > Hi
> 
> First addendum.
> 
> Deleting files from another HDD doesn't make a difference.
> (I created the next image to burn, while burning the prior. The moment i
> deleted the source-files (4.5 GB in total) the system locked up hard)

Second addendum.

Deleting a single 4.5 GB file (same partition as the image-file that was
burning) didn't lock up the system, but maybe it was sheer luck.




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

