Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264902AbSJ3WGK>; Wed, 30 Oct 2002 17:06:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264907AbSJ3WGK>; Wed, 30 Oct 2002 17:06:10 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:3855 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264902AbSJ3WGJ>; Wed, 30 Oct 2002 17:06:09 -0500
Date: Wed, 30 Oct 2002 22:12:29 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [BK fbdev updates]
Message-ID: <20021030221229.B30602@flint.arm.linux.org.uk>
Mail-Followup-To: James Simmons <jsimmons@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.33.0210301331210.1392-100000@maxwell.earthlink.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33.0210301331210.1392-100000@maxwell.earthlink.net>; from jsimmons@infradead.org on Wed, Oct 30, 2002 at 01:42:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 01:42:21PM -0800, James Simmons wrote:
>   The latest changes to the framebuffer layer are avaiable to be merged.
> The changes include the final removal of all console related code in the
> low level drivers. This allows for a very simple api. Also with this
> design is to possible to run a test/debug a fbdev driver without the
> framebuffer console. We can use another console system to see the results
> of what we have done. This will allow greater speed at developing a new
> driver because of the new simple api and the new approaches at
> debugging them. Please merge with your tree.
> 
> bk://fbdev.bkbits.net/fbdev-2.5

I'm getting sick to death of asking this.

D I F F S T A T.

G N U P A T C H.

Why can't you make a script that automatically generates these for you?

What do we need to do to you to make you do this?

If you're not willing to do your part, don't be surprised when people
ignore you when maintaining their framebuffer drivers.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

