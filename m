Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262656AbTI1TDq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 15:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262676AbTI1TDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 15:03:46 -0400
Received: from dhcp127.northsouth.iit.edu ([198.37.17.127]:9089 "EHLO
	found.lostlogicx.com") by vger.kernel.org with ESMTP
	id S262656AbTI1TDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 15:03:45 -0400
Date: Sun, 28 Sep 2003 14:03:41 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Jack Bowling <jbinpg@shaw.ca>, redhat-list@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: test5+ bombing on uhci-hcd
Message-ID: <20030928190341.GB4271@lostlogicx.com>
References: <20030928184532.GA31526@nonesuch.ca.shawcable.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030928184532.GA31526@nonesuch.ca.shawcable.net>
X-Operating-System: Linux found.lostlogicx.com 2.6.0-test5-mm2
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

this is a 'me too' I had assumed it was a hardware problem with my
sometimes flaky laptop, but I have had this exact behaviour on the
mm-series starting in about test5 as well (running Gentoo Linux)

--Brandon

On Sun, 09/28/03 at 11:45:33 -0700, Jack Bowling wrote:
> I suspect there are a few RHers tracking the mainline test kernels. If
> so, has anybody run into a problem with uhci-hcd loading? My RH 8 box hangs
> instantly with no way of recovery except for a reset. This started with
> test5 and continues with test6. According to the changelogs there have
> been many USB changes in the past couple of releases as to be expected.
> But I'll make a diff and try to wade through it anyway. Just thought I'd
> put out an initial feeler.
> 
> -- 
> Jack Bowling
> mailto: jbinpg@shaw.ca
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
