Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269735AbRHQGsr>; Fri, 17 Aug 2001 02:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269778AbRHQGsi>; Fri, 17 Aug 2001 02:48:38 -0400
Received: from [217.27.32.7] ([217.27.32.7]:38487 "EHLO leonid.francoudi.com")
	by vger.kernel.org with ESMTP id <S269735AbRHQGsW>;
	Fri, 17 Aug 2001 02:48:22 -0400
Date: Fri, 17 Aug 2001 09:39:33 +0300
From: Leonid Mamtchenkov <leonid@francoudi.com>
To: Fred Jackson <fred@arkansaswebs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: rebuiling kernel fails
Message-ID: <20010817093933.A18496@francoudi.com>
Mail-Followup-To: Fred Jackson <fred@arkansaswebs.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01081623234204.15915@bits.linuxball>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01081623234204.15915@bits.linuxball>; from fred@arkansaswebs.com on Thu, Aug 16, 2001 at 11:23:42PM -0500
X-Operating-System: Linux leonid.francoudi.com 2.4.8-lm1
X-Uptime: 9:15am  up 17:50,  4 users,  load average: 0.80, 0.77, 0.89
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Fred Jackson,

Once you wrote about "rebuiling kernel fails":
FJ> why can I build, but not re-build the 2.4.x kernels on my redhat7.1 
FJ> boxes?

Maybe because those are actually RedHat 7.0 boxes and you need to do
"make mrproper" every time you need to rebuild it...  Remember to save
your .config though - mrproper is cruel :)

-- 
 Best regards,
 Leonid Mamtchenkov
 Red Hat Certified Linux Engineer (RHCE)
 System Administrator
 Francoudi & Stephanou Ltd

