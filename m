Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWCEVxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWCEVxe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 16:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWCEVxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 16:53:33 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:60649 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751853AbWCEVxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 16:53:33 -0500
Date: Sun, 5 Mar 2006 15:53:18 -0600
From: Robin Holt <holt@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: jonathan@jonmasters.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OT] inotify hack for locate
Message-ID: <20060305215318.GA26130@lnx-holt.americas.sgi.com>
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com> <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2006 at 10:42:39PM +0100, Jesper Juhl wrote:
> On 3/5/06, Jon Masters <jonmasters@gmail.com> wrote:
> > Folks,
> >
> > I'm fed up with those finds running whenever I power on.
> 
> You run updatedb at boot time?
> Why not run it from cron at night like most people do?
> Personally I run it at 04:40.

I use suspend to disk on my laptop.  When I power it back up in the
morning, updatedb starts.

Thanks,
Robin
