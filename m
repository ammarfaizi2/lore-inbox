Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316423AbSFETRg>; Wed, 5 Jun 2002 15:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316422AbSFETRg>; Wed, 5 Jun 2002 15:17:36 -0400
Received: from ns.suse.de ([213.95.15.193]:6150 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S316339AbSFETRe>;
	Wed, 5 Jun 2002 15:17:34 -0400
Date: Wed, 5 Jun 2002 21:17:34 +0200
From: Dave Jones <davej@suse.de>
To: Boris Kimelman <erwin138@netvision.net.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pctel modem bug
Message-ID: <20020605211734.F16262@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Boris Kimelman <erwin138@netvision.net.il>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CFE6AE0.2000600@netvision.net.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 05, 2002 at 09:47:44PM +0200, Boris Kimelman wrote:
 > Hello,
 > you probably know about this but i'll tell you anyway. there is a bug 
 > related to pctel modems. a very nice person made drivers for linux of 
 > this modems and they can work on linux. the problem is that when the 
 > modem finally dials after all the configuration, it puts out a "no 
 > carrier" message and disconnects. please handle the problem and if it 
 > was already fixed please reply to me and say which kernel i should download.

Ask the very nice person who made the drivers. They contain binary only
parts that only they can fix.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
