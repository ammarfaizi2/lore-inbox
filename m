Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268295AbTBMUzg>; Thu, 13 Feb 2003 15:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268310AbTBMUzg>; Thu, 13 Feb 2003 15:55:36 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:34718 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S268295AbTBMUzf>;
	Thu, 13 Feb 2003 15:55:35 -0500
Date: Thu, 13 Feb 2003 20:59:56 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Thomas Schlichter <schlicht@uni-mannheim.de>
Cc: Michael Stolovitzsky <romat8@netvision.net.il>,
       linux-kernel@vger.kernel.org
Subject: Re: NO BOOT since 2.5.60-bk1
Message-ID: <20030213205956.GA24361@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Michael Stolovitzsky <romat8@netvision.net.il>,
	linux-kernel@vger.kernel.org
References: <200302131507.37380.schlicht@uni-mannheim.de> <200302131633.37777.romat8@netvision.net.il> <200302132007.38595.schlicht@uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302132007.38595.schlicht@uni-mannheim.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2003 at 08:07:33PM +0100, Thomas Schlichter wrote:

 > On Thursday 13 February 2003 15:33, Michael Stolovitzsky wrote:
 > > Apparently your initd fails for whichever reason. Doesn't seem to be a
 > > specifically kernel related problem.
 > 
 > Yes it seems so, but I wonder why it worked without any problem with 
 > 2.5.60...? So in any kind it IS a kernel related problem...

Can you try -bk3 ?
It may have contained some of the signal fixes that went in recently.
I'm not sure how many of those made it into -bk1/bk2.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
