Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263369AbTJaPfY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 10:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263370AbTJaPfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 10:35:24 -0500
Received: from mail.cybertrails.com ([162.42.150.35]:64450 "EHLO
	mail12.cybertrails.com") by vger.kernel.org with ESMTP
	id S263369AbTJaPfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 10:35:20 -0500
Date: Fri, 31 Oct 2003 08:35:15 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: Post-halloween doc updates.
Message-Id: <20031031083515.07f92837.dickson@permanentmail.com>
In-Reply-To: <pan.2003.10.31.12.25.07.551785@dungeon.inka.de>
References: <20031030141519.GA10700@redhat.com>
	<pan.2003.10.31.12.25.07.551785@dungeon.inka.de>
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Oct 2003 13:25:08 +0100, Andreas Jellinghaus wrote:

> On Thu, 30 Oct 2003 14:19:47 +0000, Dave Jones wrote:
> > Deprecated/obsolete features.
> > ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > - devfs has been obsoleted in favour of udev (http://www.kernel.org/pub/linux/utils/kernel/hotplug/)
> 
> s/has been obsoleted/will be olsoleted some day/
> 
> many devices need to be added to sysfs,
> before udev+sysfs can replace devfs.

So the correct term should be deprecated rather than obsoleted.  Which can
be taken to mean "please which switch when possible".

	-Paul

