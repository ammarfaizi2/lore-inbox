Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261249AbVALS4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261249AbVALS4a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 13:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbVALSyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 13:54:44 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:10942 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261275AbVALSvk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 13:51:40 -0500
Date: Wed, 12 Jan 2005 10:41:27 -0800
From: Greg KH <greg@kroah.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, paulmck@us.ibm.com,
       arjan@infradead.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com, Linus Torvalds <torvalds@osdl.org>, linux@brodo.de
Subject: Re: [PATCH] add feature-removal-schedule.txt documentation
Message-ID: <20050112184127.GA10599@kroah.com>
References: <20050106190538.GB1618@us.ibm.com> <1105039259.4468.9.camel@laptopd505.fenrus.org> <20050106201531.GJ1292@us.ibm.com> <20050106203258.GN26051@parcelfarce.linux.theplanet.co.uk> <20050106210408.GM1292@us.ibm.com> <20050106212417.GQ26051@parcelfarce.linux.theplanet.co.uk> <20050106152621.395f935e.akpm@osdl.org> <20050106235633.GA10110@kroah.com> <41DEC0BF.4010708@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41DEC0BF.4010708@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2005 at 09:02:55AM -0800, Randy.Dunlap wrote:
> Greg KH wrote:
> >On Thu, Jan 06, 2005 at 03:26:21PM -0800, Andrew Morton wrote:
> >
> >>Which begs the question "how do we ever get rid of these things when we
> >>have no projected date for Linux-2.8"?
> >>
> >>I'd propose:
> >>
> >>a) Create Documentation/feature-removal-schedule.txt which describes
> >>  things which are going away, when, why, who is involved, etc.
> >
> >Ok, I'll bite, here's a patch that does just that.  Look good?
> 
> Brodo, can you add a little more info to this, please?
> 
> ---
> Add 2.4.x cpufreq /proc and sysctl interface removal
> to the feature-removal-schedule.
> 
> Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

Applied, thanks.

greg k-h
