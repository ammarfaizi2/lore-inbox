Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262914AbTJZHnH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 02:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbTJZHnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 02:43:07 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:5620 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S262914AbTJZHnD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 02:43:03 -0500
Date: Sun, 26 Oct 2003 20:42:50 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1
In-reply-to: <20031025200524.GA1170@iain-vaio-fx405>
To: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1067154164.14037.55.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1067069558.1975.54.camel@laptop-linux>
 <20031025192019.GA1033@iain-vaio-fx405> <20031025200524.GA1170@iain-vaio-fx405>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You should be able to press escape to cancel; if the message stays for
more than a couple of seconds, something is wrong. When you cancel, you
should get messages in the log that will help me diagnose and fix the
issue. You may need to run them through ksymoops to convert hex to
procedure names.

Regards,

Nigel

On Sun, 2003-10-26 at 09:05, iain d broadfoot wrote:
> * iain d broadfoot (ibroadfo@cis.strath.ac.uk) wrote:
> > * Nigel Cunningham (ncunningham@clear.net.nz) wrote:
> > > Hi all.
> > > 
> > > I'm pleased to be able to announce the first test release of a port of
> > > the current 2.0 pre-release Software Suspend code to 2.6. 
> > 
> > hurrah!
> > 
> > The attached patch allowed the kernel to compile for me, haven't booted
> > into it as yet.
> 
> when trying to suspend (either by directly echoing > /proc/swsusp/activate,
> or with the script) It only gets as far as the first screen "killing
> processes/freeing space" (can't remember the exact message despite
> staring at it for a good 20 mins total today)
> 
> the 'r' and 'l' keys both change the message, toggling reboot and
> logging respectively, but no other keys have any effect.
> 
> cheers,
> iain
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

