Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbTC0WY0>; Thu, 27 Mar 2003 17:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbTC0WY0>; Thu, 27 Mar 2003 17:24:26 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:28653 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261440AbTC0WYZ>; Thu, 27 Mar 2003 17:24:25 -0500
Date: Thu, 27 Mar 2003 14:37:14 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, David Brownell <david-b@pacbell.net>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.recent: device_remove_file() doesn't
Message-ID: <20030327223714.GB11246@beaverton.ibm.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Patrick Mochel <mochel@osdl.org>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
References: <3E8275AD.40603@pacbell.net> <Pine.LNX.4.33.0303271154080.1001-100000@localhost.localdomain> <20030327200413.GA1687@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030327200413.GA1687@kroah.com>
X-Operating-System: Linux 2.0.32 on an i486
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH [greg@kroah.com] wrote:
> On Thu, Mar 27, 2003 at 11:58:14AM -0600, Patrick Mochel wrote:
> > 
> > Greg/Mike, could you give this patch a shot and let me know if helps?
> 
> Yes, this seems to fix the symlink problem I was seeing before, thanks.
> 

It has also fixed my symlink issue.

thanks,

-andmike
--
Michael Anderson
andmike@us.ibm.com

