Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTLDGge (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 01:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTLDGge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 01:36:34 -0500
Received: from [66.35.79.110] ([66.35.79.110]:13709 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S262796AbTLDGge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 01:36:34 -0500
Date: Wed, 3 Dec 2003 18:37:31 -0800
From: Tim Hockin <thockin@hockin.org>
To: Greg KH <greg@kroah.com>
Cc: Fredrik Tolf <fredrik@dolda2000.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Message-ID: <20031204023731.GA6751@hockin.org>
References: <16334.31260.278243.22272@pc7.dolda2000.com> <20031204011357.GA22506@kroah.com> <16334.38227.433336.514399@pc7.dolda2000.com> <20031204022911.GA23761@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031204022911.GA23761@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 06:29:12PM -0800, Greg KH wrote:
> I would suggest reading this post from Linus for a quick summary:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=105552804303171

I don't really see what's so bad about acpid.  The code is dead simple.
Now, I'm not saying it is better than hotplug, but I really don't see them
as being too different.

Sorry to chime in :)
