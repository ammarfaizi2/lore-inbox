Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292773AbSBUV7m>; Thu, 21 Feb 2002 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292774AbSBUV7c>; Thu, 21 Feb 2002 16:59:32 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:23822 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S292773AbSBUV7W>;
	Thu, 21 Feb 2002 16:59:22 -0500
Date: Thu, 21 Feb 2002 13:53:55 -0800
From: Greg KH <greg@kroah.com>
To: Adam <ambx1@netscape.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs question
Message-ID: <20020221215355.GH4984@kroah.com>
In-Reply-To: <3C755A8A.90000@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C755A8A.90000@netscape.net>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Thu, 24 Jan 2002 18:54:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 03:37:30PM -0500, Adam wrote:
> 
> How will the devices in the driverfs be arranged?
> It seems to me that it could only be one of the following three methods.

Have you looked at the current code and seen how stuff is already layed
out?  It seems to match your "Method 3" already.  Are you proposing the
current implementation should be changed?

thanks,

greg k-h
