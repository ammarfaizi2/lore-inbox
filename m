Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266499AbRGLS2d>; Thu, 12 Jul 2001 14:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266500AbRGLS2Y>; Thu, 12 Jul 2001 14:28:24 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:776 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266499AbRGLS2M>;
	Thu, 12 Jul 2001 14:28:12 -0400
Date: Thu, 12 Jul 2001 11:25:04 -0700
From: Greg KH <greg@kroah.com>
To: Hans Reiser <reiser@namesys.com>
Cc: LA Walsh <law@sgi.com>, reiserfs-dev@namesys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: Security hooks, "standard linux security" & embedded use
Message-ID: <20010712112504.E32683@kroah.com>
In-Reply-To: <3B49F602.DB39B3A@sgi.com> <3B4DDFD8.27C1C3D9@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4DDFD8.27C1C3D9@namesys.com>; from reiser@namesys.com on Thu, Jul 12, 2001 at 09:35:20PM +0400
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 09:35:20PM +0400, Hans Reiser wrote:
> Hi Linda,
> 
> This seems very much in line with what Reiser4 is doing for DARPA, and what SE Linux is doing for
> the NSA.  Or at least what Linus told the SE Linux folks he would like them to write.:-)
> 
> I am quite supportive of what you advocate generally, and I look forward to cooperating with you in
> the details.

The details can be currently found in the most recent patch against
2.4.6 at:
	http://lsm.immunix.org/patches/lsm-2001_07_06-2.4.6.patch.gz

There's a bit more information available, including the latest version
of the patch at all times, available as a bitkeeper repository at:
	http://lsm.immunix.org/

thanks,

greg k-h
