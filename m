Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314126AbSDQPPk>; Wed, 17 Apr 2002 11:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314128AbSDQPPj>; Wed, 17 Apr 2002 11:15:39 -0400
Received: from ns.suse.de ([213.95.15.193]:20230 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314126AbSDQPPi>;
	Wed, 17 Apr 2002 11:15:38 -0400
Date: Wed, 17 Apr 2002 17:15:35 +0200
From: Dave Jones <davej@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5-dj] P4 thermal LVT (damage control)
Message-ID: <20020417171534.A29982@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020417144945.H32185@suse.de> <Pine.LNX.4.44.0204171437030.30470-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 02:40:59PM +0200, Zwane Mwaikambo wrote:
 > On Wed, 17 Apr 2002, Dave Jones wrote:
 > 
 > > more icky ifdefs, but I don't think we can do this cleanly any other
 > > way without ripping things apart to something like a bluesmoke-p4.c
 > > and the likes.
 > 
 > Its your call, i can split it up if worst comes to worst.

I'll take a look at it when Patrick Mochel's arch/i386/kernel/ splitup
gets merged.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
