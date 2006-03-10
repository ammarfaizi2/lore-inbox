Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751467AbWCJQsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbWCJQsl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751860AbWCJQsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:48:41 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:61413
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751467AbWCJQsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:48:40 -0500
Date: Fri, 10 Mar 2006 08:48:08 -0800
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, "Bryan O'Sullivan" <bos@pathscale.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310164808.GA11176@suse.de>
References: <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com> <20060310010050.GA9945@suse.de> <1141966693.14517.20.camel@camp4.serpentine.com> <1141977431.2876.18.camel@laptopd505.fenrus.org> <1141998702.28926.15.camel@localhost.localdomain> <1141999569.2876.47.camel@laptopd505.fenrus.org> <1142006121.29925.5.camel@serpentine.pathscale.com> <20060310162552.GB18755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060310162552.GB18755@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 11:25:52AM -0500, Dave Jones wrote:
> On Fri, Mar 10, 2006 at 07:55:21AM -0800, Bryan O'Sullivan wrote:
> 
>  > If Greg can get SUSE to turn on debugfs, that's great.  I can ask Dave
>  > Jones or Doug Ledford or some other Fedora/RedHat kernel person to do
>  > likewise, but they're not beholden to me in any way, so god knows what
>  > my chances are :-)
> 
> I've acknowledged it was already enabled.

And I just looked at the SuSE kernel, and it is already enabled too.  So
it looks like Bryan didn't even check either distro before saying it
wasn't there :(

thanks,

greg k-h
