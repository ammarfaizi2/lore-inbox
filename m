Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262987AbUKRXxl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbUKRXxl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbUKRXwV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:52:21 -0500
Received: from gate.ebshome.net ([64.81.67.12]:30865 "EHLO gate.ebshome.net")
	by vger.kernel.org with ESMTP id S263004AbUKRXqa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:46:30 -0500
Date: Thu, 18 Nov 2004 15:46:29 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] a very tiny /sbin/hotplug
Message-ID: <20041118234629.GA3046@gate.ebshome.net>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	linux-hotplug-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20041118231406.GA11239@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118231406.GA11239@kroah.com>
X-ICQ-UIN: 1193073
X-Operating-System: Linux i686
X-PGP-Key: http://www.ebshome.net/pubkey.asc
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 03:14:06PM -0800, Greg Kroah-Hartman wrote:
> So, a number of people have complained over the past few years about the
> fact that /sbin/hotplug was a shell script.  Funny enough, it's the
> people on the huge boxes, with huge number of devices that are
> complaining, not the embedded people with limited resources (ironic,
> isn't it...)

This is probably because embedded people don't use hotplug at all :).
On dozen different PPC and MIPS boxes I worked on, we never needed 
this feature.

--
Eugene
