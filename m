Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267189AbUGWGbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267189AbUGWGbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 02:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267164AbUGWGbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 02:31:51 -0400
Received: from herkules.viasys.com ([194.100.28.129]:54216 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S267189AbUGWGbe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 02:31:34 -0400
Date: Fri, 23 Jul 2004 09:31:31 +0300
From: Ville Herva <vherva@viasys.com>
To: Tim Wright <timw@splhi.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Paul Jackson <pj@sgi.com>, akpm@osdl.org,
       corbet@lwn.net, linux-kernel@vger.kernel.org
Subject: Re: New dev model (was [PATCH] delete devfs)
Message-ID: <20040723063131.GJ16073@viasys.com>
Reply-To: vherva@viasys.com
References: <40FEEEBC.7080104@quark.didntduck.org> <20040721231123.13423.qmail@lwn.net> <20040721235228.GZ14733@fs.tum.de> <20040722025539.5d35c4cb.akpm@osdl.org> <20040722193337.GE19329@fs.tum.de> <20040722152839.019a0ca0.pj@sgi.com> <20040722232540.GH19329@fs.tum.de> <1090549329.6113.21.camel@kryten.internal.splhi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090549329.6113.21.camel@kryten.internal.splhi.com>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 07:22:10PM -0700, you [Tim Wright] wrote:
> > 
> > How do such end users get security updates?
> 
> From the middleman. That's no different to users of any distros today.
> The distros apply security fixes and make updated kernels available on a
> regular basis.

One idea might be to fork off "stable" 2.6.x.y (2.6.15.1 for example)
branches every now and them. Analogous to vendor kernels, but maintained by
someone@kernel.org. Compared to the 2.6.x.0 in question, these would only
get security fixes and important bug fixes. The maintainer would need to
pick a suitable (stable) 2.6.x.0 as basis every once in an appropriate
while.

I don't know if that's feasible. Just an idea.

Anyway, as (one kind of) end user, I do welcome the new development model.
I'll get the newest features in manageable manner, and if I don't fancy that
I can resort to vendor (Fedora) kernels.


-- v -- 

v@iki.fi

