Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262968AbTI2Jss (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbTI2Jss
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:48:48 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:38021
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S262968AbTI2JsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:48:24 -0400
Date: Mon, 29 Sep 2003 05:48:09 -0400 (EDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Jack Bowling <jbinpg@shaw.ca>
cc: redhat-list@redhat.com, <linux-kernel@vger.kernel.org>
Subject: Re: test5+ bombing on uhci-hcd
In-Reply-To: <20030928184532.GA31526@nonesuch.ca.shawcable.net>
Message-ID: <Pine.LNX.4.44.0309290545440.14952-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Sep 2003, Jack Bowling wrote:

> I suspect there are a few RHers tracking the mainline test kernels. If
> so, has anybody run into a problem with uhci-hcd loading? My RH 8 box hangs
> instantly with no way of recovery except for a reset. This started with
> test5 and continues with test6. According to the changelogs there have
> been many USB changes in the past couple of releases as to be expected.
> But I'll make a diff and try to wade through it anyway. Just thought I'd
> put out an initial feeler.

I've been running dev kernels on several boxes with no trouble concerning 
uhci-hcd at all.  The one thing I would suggest is you check that you have 
the latest version of the module-init-tools.  

