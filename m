Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292268AbSBBMeZ>; Sat, 2 Feb 2002 07:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292270AbSBBMeR>; Sat, 2 Feb 2002 07:34:17 -0500
Received: from ns.suse.de ([213.95.15.193]:61449 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292268AbSBBMeA>;
	Sat, 2 Feb 2002 07:34:00 -0500
Date: Sat, 2 Feb 2002 13:33:58 +0100
From: Dave Jones <davej@suse.de>
To: Nathan <wfilardo@fuse.net>
Cc: Greg KH <greg@kroah.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Issues with 2.5.3-dj1
Message-ID: <20020202133358.A5738@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Nathan <wfilardo@fuse.net>, Greg KH <greg@kroah.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C5B5EC0.40503@fuse.net> <20020202055115.GA11359@kroah.com> <3C5B8C0D.8090009@fuse.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C5B8C0D.8090009@fuse.net>; from wfilardo@fuse.net on Sat, Feb 02, 2002 at 01:49:49AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 02, 2002 at 01:49:49AM -0500, Nathan wrote:

 > Alright... a 2.5.3 with no extras boots fine (with init=/bin/bash) and 
 > can load and unload hotplug several times without OOPSing.  So it 
 > appears to be something else.  Hope that helps.

 Do you have driverfs mounted ? Can you try 2.5.3 + greg's
 USB driverfs patch ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
