Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131704AbRCONZP>; Thu, 15 Mar 2001 08:25:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131705AbRCONYz>; Thu, 15 Mar 2001 08:24:55 -0500
Received: from x86unx3.comp.nus.edu.sg ([137.132.90.2]:42953 "EHLO
	x86unx3.comp.nus.edu.sg") by vger.kernel.org with ESMTP
	id <S131704AbRCONYn>; Thu, 15 Mar 2001 08:24:43 -0500
Date: Thu, 15 Mar 2001 21:23:41 +0800
From: Zou Min <zoum@comp.nus.edu.sg>
To: linux-kernel@vger.kernel.org
Subject: A simple question on buffer/cache
Message-ID: <20010315212341.B7191@comp.nus.edu.sg>
Mail-Followup-To: Zou Min <zoum@comp.nus.edu.sg>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just wonder what exactly the difference between buffer and cache in linux 
memory management is.
Cache is used for filesystems, so that files read from a fs are kept in
memory in order to provide faster access next time.
Then what is buffer used for?
As executables are also kept in memory, are they in cache or buffer? 

Can somebody give any details on this? Many thanks!

-- 
Cheers!
--Zou Min 
-----------------------------------------------------------------------------
"Any technology indistinguishable from magic is insufficiently advanced."
