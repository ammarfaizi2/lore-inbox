Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVC0Nxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVC0Nxw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 08:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVC0Nxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 08:53:52 -0500
Received: from levante.wiggy.net ([195.85.225.139]:30924 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261655AbVC0Nxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 08:53:42 -0500
Date: Sun, 27 Mar 2005 15:53:38 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Sean <seanlkml@sympatico.ca>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327135338.GB14696@wiggy.net>
Mail-Followup-To: Sean <seanlkml@sympatico.ca>,
	Mark Fortescue <mark@mtfhpc.demon.co.uk>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.10.10503261710320.13484-100000@mtfhpc.demon.co.uk> <1824.10.10.10.24.1111927362.squirrel@linux1>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1824.10.10.10.24.1111927362.squirrel@linux1>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Sean wrote:
> On Sat, March 26, 2005 12:52 pm, Mark Fortescue said:
> > In order to be able to use SYSFS to debug the driver during development
> > the way I would like to be able to do, I will have to temporally change
> > the module licence line to "GPL". When the development is finnished I
> > then need to remove all the code that accesses the SYSFS stuf in the
> > Kernel and change the module back to a "Proprietry" licence in order to
> > comply with other requirements. This will then hinder any debugging if
> > future issues arise.
> 
> Likely this won't be enough to keep you or your company from being sued.

Are you sure? It is perfectly legal to relicense things if you own the
copyright. As long as he never distributes his GPL version I don't see
why he should have a problem.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
