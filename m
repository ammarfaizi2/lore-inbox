Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTDKU3c (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 16:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbTDKU3c (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 16:29:32 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:31970 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261693AbTDKU3b (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 16:29:31 -0400
Date: Fri, 11 Apr 2003 13:43:29 -0700
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: "Kevin P. Fleming" <kpfleming@cox.net>,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       message-bus-list@redhat.com
Subject: Re: [ANNOUNCE] udev 0.1 release
Message-ID: <20030411204329.GT1821@kroah.com>
References: <20030411172011.GA1821@kroah.com> <200304111746.h3BHk9hd001736@81-2-122-30.bradfords.org.uk> <20030411182313.GG25862@wind.cocodriloo.com> <3E970A00.2050204@cox.net> <3E9725C5.3090503@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E9725C5.3090503@mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 11, 2003 at 01:29:57PM -0700, Steven Dake wrote:
> 
> It gets even worse, because performance of hotswap events on disk adds 
> is critical and spawning processes is incredibly slow compared to the 
> performance required by some telecom applications...

It's critical that we quick name this disk within X milliseconds after
it has been added to the system?  What spec declares this?

thanks,

greg k-h
