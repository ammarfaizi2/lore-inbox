Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262002AbVAHJot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262002AbVAHJot (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 04:44:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVAHJgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 04:36:10 -0500
Received: from smtp-relay.dca.net ([216.158.48.66]:5345 "EHLO
	smtp-relay.dca.net") by vger.kernel.org with ESMTP id S261958AbVAHGWy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 01:22:54 -0500
Date: Sat, 8 Jan 2005 01:22:51 -0500
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com,
       Jonas Munsin <jmunsin@iki.fi>
Subject: Re: [PATCH] I2C patches for 2.6.10
Message-ID: <20050108062251.GA5006@jupiter.solarsys.private>
References: <11051627762989@kroah.com> <11051627762271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11051627762271@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all:

* Greg KH <greg@kroah.com> [2005-01-07 21:39:36 -0800]:
> ChangeSet 1.1938.445.11, 2004/12/21 11:09:49-08:00, jmunsin@iki.fi
> 
> [PATCH] I2C: it87.c update
> 
>  - adds manual PWM
>  - removes buggy "reset" module parameter
>  - fixes some whitespaces
> 
> Signed-off-by: Jonas Munsin <jmunsin@iki.fi>
> Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

You might hold off on this one patch... see this:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110514540928517&w=3

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

