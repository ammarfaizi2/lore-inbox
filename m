Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbUKRXzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUKRXzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUKRXxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:53:53 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:65262 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262916AbUKRXxF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:53:05 -0500
Date: Thu, 18 Nov 2004 17:53:01 -0600
From: Chris Larson <kergoth@handhelds.org>
To: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc: Greg KH <greg@kroah.com>
Subject: Re: [ANNOUNCE] a very tiny /sbin/hotplug
Message-ID: <20041118235301.GD19750@rikers.org>
Mail-Followup-To: linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>
References: <20041118231406.GA11239@kroah.com> <20041118234629.GA3046@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118234629.GA3046@gate.ebshome.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eugene Surovegin (ebs@ebshome.net) wrote:
> On Thu, Nov 18, 2004 at 03:14:06PM -0800, Greg Kroah-Hartman wrote:
> > So, a number of people have complained over the past few years about the
> > fact that /sbin/hotplug was a shell script.  Funny enough, it's the
> > people on the huge boxes, with huge number of devices that are
> > complaining, not the embedded people with limited resources (ironic,
> > isn't it...)
> 
> This is probably because embedded people don't use hotplug at all :).
> On dozen different PPC and MIPS boxes I worked on, we never needed 
> this feature.

I tend to focus on ARM, and find this very useful.  I know of a number
of folks using erik andersen's "diethotplug" (which hasnt been touched
in some time).  I look forward to your further hotplug improvements.
--
Chris Larson - kergoth at handhelds dot org
Linux Software Systems Engineer - clarson at ti dot com
OpenZaurus Project Maintainer - http://openzaurus.org/
