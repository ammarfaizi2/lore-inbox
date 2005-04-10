Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVDJVot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVDJVot (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 17:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261614AbVDJVot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 17:44:49 -0400
Received: from [83.246.78.200] ([83.246.78.200]:8924 "EHLO srvh02.vc-server.de")
	by vger.kernel.org with ESMTP id S261613AbVDJVor convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 17:44:47 -0400
Date: Sun, 10 Apr 2005 21:46:45 +0000
From: Dennis Heuer <dh@triple-media.com>
Subject: Re: 2.6.11.x: bootprompt: ALSA: no soundcard detected
To: linux-kernel@vger.kernel.org
References: <1113121569l.584l.0l@Foo>
	<2a4f155d05041002022788ae8b@mail.gmail.com> <1113128209l.588l.0l@Foo>
	<2a4f155d05041006096b203aed@mail.gmail.com> <1113165575l.556l.1l@Foo>
In-Reply-To: <1113165575l.556l.1l@Foo> (from dh@triple-media.com on Sun Apr
	10 22:39:35 2005)
X-Mailer: Balsa 2.2.5
Message-Id: <1113169605l.556l.6l@Foo>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - srvh02.vc-server.de
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - triple-media.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aehhm, you are completely on the wrong track! I installed 2.6.11.7 the same way I installed 2.6.11, with sound support statically included, but, though it worked fine without ACPI under 2.6.11, the same configuration under 2.6.11.7 does not work. There was no change in practise, only a change in behaviour.
 
Dennis


> That means you didn't load the correct module for your soundcard.
> 
> 
> On Sun, 10 Apr 2005 10:16:49 +0000, Dennis Heuer <dh@triple-media.com> wrote:
> > This doesn't help. Alsamixer prints:
> > 
> > failure in snd_ctl_open: no such device
> > 
> > Dennis
> 
> -- 
> Time is what you make of it
> 
> 
> 
> 
> 


