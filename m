Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132754AbRDDHAq>; Wed, 4 Apr 2001 03:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132755AbRDDHAg>; Wed, 4 Apr 2001 03:00:36 -0400
Received: from dial082.za.nextra.sk ([195.168.64.82]:772 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S132756AbRDDHA1>;
	Wed, 4 Apr 2001 03:00:27 -0400
Date: Wed, 4 Apr 2001 09:57:33 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Subject: Re: Basic Text Mode (was: Re: Question about SysRq)
Message-ID: <20010404095733.A1922@Boris>
In-Reply-To: <Pine.LNX.4.31.0104021953570.3867-100000@linux.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104021953570.3867-100000@linux.local>; from jsimmons@linux-fbdev.org on Mon, Apr 02, 2001 at 07:59:15PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some stupid questions about videomem:

1) How do 2 or more X servers, or svgalibbed apps share the same physical video
memory ? Does it get saved to ram when switching between them ? 

2) Does console switching (gfx or text) save and restore all registers of
videocard in kernel ? Or kernel only restores text things and gfx apps must
it do in their own ?


 
