Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750782AbWCJQ1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbWCJQ1P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 11:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWCJQ1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 11:27:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:44493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750782AbWCJQ1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 11:27:14 -0500
Date: Fri, 10 Mar 2006 11:25:52 -0500
From: Dave Jones <davej@redhat.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
       Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
       davem@davemloft.net, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: Revenge of the sysfs maintainer! (was Re: [PATCH 8 of 20] ipath - sysfs support for core driver)
Message-ID: <20060310162552.GB18755@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Bryan O'Sullivan <bos@pathscale.com>,
	Arjan van de Ven <arjan@infradead.org>, Greg KH <gregkh@suse.de>,
	Roland Dreier <rdreier@cisco.com>, rolandd@cisco.com, akpm@osdl.org,
	davem@davemloft.net, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <adapskvfbqe.fsf@cisco.com> <1141947143.10693.40.camel@serpentine.pathscale.com> <20060310003513.GA17050@suse.de> <1141951589.10693.84.camel@serpentine.pathscale.com> <20060310010050.GA9945@suse.de> <1141966693.14517.20.camel@camp4.serpentine.com> <1141977431.2876.18.camel@laptopd505.fenrus.org> <1141998702.28926.15.camel@localhost.localdomain> <1141999569.2876.47.camel@laptopd505.fenrus.org> <1142006121.29925.5.camel@serpentine.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142006121.29925.5.camel@serpentine.pathscale.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2006 at 07:55:21AM -0800, Bryan O'Sullivan wrote:

 > If Greg can get SUSE to turn on debugfs, that's great.  I can ask Dave
 > Jones or Doug Ledford or some other Fedora/RedHat kernel person to do
 > likewise, but they're not beholden to me in any way, so god knows what
 > my chances are :-)

I've acknowledged it was already enabled.
I've posted a log from a shell session showing that it's there in /proc/filesystems
in current builds.

What more exactly do you want?

		Dave

-- 
http://www.codemonkey.org.uk
