Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWHIUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWHIUdO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 16:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHIUdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 16:33:14 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:13284 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751335AbWHIUdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 16:33:14 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: swsusp and suspend2 like to overheat my laptop
Date: Wed, 9 Aug 2006 22:32:03 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
       Suspend2-devel@lists.suspend2.net, linux-pm@osdl.org,
       ncunningham@linuxmail.org
References: <Pine.LNX.4.58.0608081612380.17442@gandalf.stny.rr.com> <200608091415.51226.rjw@sisk.pl> <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
In-Reply-To: <Pine.LNX.4.58.0608090913480.3560@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608092232.03360.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 August 2006 15:16, Steven Rostedt wrote:
> 
> On Wed, 9 Aug 2006, Rafael J. Wysocki wrote:
> 
> >
> > If it's a P4, we rather don't, because the ACPI tables should be above the
> > last pfn in the normal zone.  Still, Steven please send your dmesg after a
> > fresh boot.
> >
> 
> Attached is a gzipped version of my dmesg.

Thanks.

I don't think we overwrite anything important from the hardware's perspective.

Rafael
