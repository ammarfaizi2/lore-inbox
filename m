Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310345AbSCBHdL>; Sat, 2 Mar 2002 02:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310346AbSCBHdB>; Sat, 2 Mar 2002 02:33:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:24851 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310345AbSCBHcu>;
	Sat, 2 Mar 2002 02:32:50 -0500
Date: Fri, 1 Mar 2002 23:25:49 -0800
From: Greg KH <greg@kroah.com>
To: Andrew Park <apark@cdf.toronto.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: booting from disk on key?
Message-ID: <20020302072549.GC20536@kroah.com>
In-Reply-To: <Pine.LNX.4.30.0203010003320.21594-100000@penguin.cdf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0203010003320.21594-100000@penguin.cdf>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 02 Feb 2002 05:03:18 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 12:22:43AM -0500, Andrew Park wrote:
> Has anybody successfully booted from disk on key?
> 
> I am trying to see if there is a way to load the whole system, instead
> of using it merely as a root disk.
> 
> My mother board supports booting from USB disks and my IBM disk on key
> has USB interface, so I thought perhaps there is a way...

Yes you can.  See:
	http://marc.theaimsgroup.com/?t=101500519000001&r=1&w=2
For a patch that you will need.

Good luck,

greg k-h
