Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbTC0TyD>; Thu, 27 Mar 2003 14:54:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261326AbTC0TyD>; Thu, 27 Mar 2003 14:54:03 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:54792 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261321AbTC0TyC>;
	Thu, 27 Mar 2003 14:54:02 -0500
Date: Thu, 27 Mar 2003 12:04:13 -0800
From: Greg KH <greg@kroah.com>
To: Patrick Mochel <mochel@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
       andmike@us.ibm.com
Subject: Re: 2.5.recent: device_remove_file() doesn't
Message-ID: <20030327200413.GA1687@kroah.com>
References: <3E8275AD.40603@pacbell.net> <Pine.LNX.4.33.0303271154080.1001-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303271154080.1001-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 27, 2003 at 11:58:14AM -0600, Patrick Mochel wrote:
> 
> Greg/Mike, could you give this patch a shot and let me know if helps?

Yes, this seems to fix the symlink problem I was seeing before, thanks.

greg k-h
