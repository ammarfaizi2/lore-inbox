Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbTFZNXo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 09:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbTFZNXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 09:23:43 -0400
Received: from mail.ithnet.com ([217.64.64.8]:6660 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261454AbTFZNXl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 09:23:41 -0400
Date: Thu, 26 Jun 2003 15:38:20 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21 pooched?
Message-Id: <20030626153820.4147ec9a.skraw@ithnet.com>
In-Reply-To: <200306260006360780.0086B340@smtp.comcast.net>
References: <200306260006360780.0086B340@smtp.comcast.net>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jun 2003 00:06:36 -0400
rmoser <mlmoser@comcast.net> wrote:

> I'm having serious issues with 2.4.21.  It seems it doesn't like
> ide-scsi, but panics/oops'es (something, it freezes afterwards
> and blinks my kb) in ide-iops.c somewhere (ZIP/CDRW on
> ide-scsi).  Also, the USB code seems to crash the system all
> the time.  Gnome2 can't even begin to load, and when I kill X,
> it takes the system down with it.
> 
> Everything I do is stable and safe in 2.4.18 through 2.4.20.  I
> have had absolutely no panics or oopses until now with 2.4
> series kernels.  I believe that the 2.4.21 kernel may be pooched.
> Check that out if you haven't already heard of it.
> 
> By the way, some people tell me 2.4.21 is stable, and others
> (more of 'em) tell me it's evil.  I dunno, play with it.
> 
> --Bluefox Icy

If you see oopses then we could have a good chance to read them, too?

Regards,
Stephan
