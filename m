Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316021AbSEVPVJ>; Wed, 22 May 2002 11:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316088AbSEVPVI>; Wed, 22 May 2002 11:21:08 -0400
Received: from ns.suse.de ([213.95.15.193]:26116 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S316021AbSEVPVH>;
	Wed, 22 May 2002 11:21:07 -0400
Date: Wed, 22 May 2002 17:21:06 +0200
From: Dave Jones <davej@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
Message-ID: <20020522172106.F28394@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Padraig Brady <padraig@antefacto.com>, linux-kernel@vger.kernel.org
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu> <3CEBA2D4.4080804@evision-ventures.com> <3CEBB42D.3070807@antefacto.com> <3CEBA61D.1000709@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 22, 2002 at 04:07:25PM +0200, Martin Dalecki wrote:
 > > The new cpufreq dynamic frequency scaling
 > > stuff changes "cpu MHz" and "bogomips" at least.
 > Both are sysctl stuff -> /proc/sys/kernel/cpu/

It also changes /proc/cpuinfo to remain coherent.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
