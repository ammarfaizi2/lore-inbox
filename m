Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292420AbSBUPCw>; Thu, 21 Feb 2002 10:02:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292419AbSBUPCp>; Thu, 21 Feb 2002 10:02:45 -0500
Received: from ns.suse.de ([213.95.15.193]:52753 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292420AbSBUPCb>;
	Thu, 21 Feb 2002 10:02:31 -0500
Date: Thu, 21 Feb 2002 16:02:28 +0100
From: Dave Jones <davej@suse.de>
To: David Burrows <snadge@ugh.net.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: baffling linux bug / hardware problem
Message-ID: <20020221160228.E5583@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	David Burrows <snadge@ugh.net.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20020222013558.X11925-100000@starbug.ugh.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020222013558.X11925-100000@starbug.ugh.net.au>; from snadge@ugh.net.au on Fri, Feb 22, 2002 at 01:53:10AM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2002 at 01:53:10AM +1100, David Burrows wrote:
 > I have a problem where my computer locks up during "Calibrating Delay
 > Loop..".  I have been using Linux on this same hardware for many years,
 > and it only started doing this 2 days ago.  It does not seem to matter
 > what kernel version (2.0, 2.2, 2.4.17) I use or what medium I boot from.

 I had an old Winchip box that did this. Turned out to be a bad SIMM.
 Try running memtest86 for a while. 

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
