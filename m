Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266094AbUALJs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 04:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266107AbUALJs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 04:48:57 -0500
Received: from smtp-out2.iol.cz ([194.228.2.87]:36996 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S266094AbUALJsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 04:48:14 -0500
Date: Mon, 12 Jan 2004 10:47:02 +0100
From: Pavel Machek <pavel@suse.cz>
To: George Anzinger <george@mvista.com>
Cc: "Amit S. Kale" <amitkale@emsyssoft.com>, Andrew Morton <akpm@osdl.org>,
       jim.houston@comcast.net, discuss@x86-64.org, ak@suse.de,
       shivaram.upadhyayula@wipro.com, lkml <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [discuss] Re: kgdb for x86_64 2.6 kernels
Message-ID: <20040112094702.GB10869@elf.ucw.cz>
References: <000e01c3d476$2ebe03a0$4008720a@shivram.wipro.com> <200401091031.41493.amitkale@emsyssoft.com> <3FFF2851.4060501@mvista.com> <200401101611.53510.amitkale@emsyssoft.com> <400237F0.9020407@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400237F0.9020407@mvista.com>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >I'll attempt reading your patch and merging as much stuff as possible.
> >Thanks.
> 
> May I suggest reading the comments preceeding the patch itself in Andrew's 
> breakout code.  These were written by Ingo and, I think, reflect some of 
> the things he found useful.
> 
> Also, the information found in .../Documentation/i386/kgdb/* of the
>patch.

Some docs would be nice, but we probably want to have it in
Documentation/kgdb/, as it is no longer i386-specific.

								Pavel
-- 
When do you have heart between your knees?
