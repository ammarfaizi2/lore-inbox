Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313583AbSDQTcy>; Wed, 17 Apr 2002 15:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313585AbSDQTcx>; Wed, 17 Apr 2002 15:32:53 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:34577 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313583AbSDQTcw>;
	Wed, 17 Apr 2002 15:32:52 -0400
Date: Wed, 17 Apr 2002 11:31:57 -0700
From: Greg KH <greg@kroah.com>
To: "Stephen J. Gowdy" <gowdy@slac.stanford.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        David Brownell <david-b@pacbell.net>,
        linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB device support for 2.5.8 (take 2)
Message-ID: <20020417183156.GE1162@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0204171043260.17271-100000@home.transmeta.com> <Pine.LNX.4.44.0204171140450.1793-100000@router-273.sgowdy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 20 Mar 2002 15:42:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 17, 2002 at 11:41:14AM -0700, Stephen J. Gowdy wrote:
> gadget? non-host?

"gadget" is nice.  It's descriptive of what the code is for, without the
bad connotations that "slave" seems to have.

Although those people who actually take USB seriously might not like it
so much, but I don't see any of those people doing Linux development
anyway :)

thanks,

greg k-h
