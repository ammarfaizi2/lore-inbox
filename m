Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWBGARV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWBGARV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 19:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWBGARV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 19:17:21 -0500
Received: from detroit.securenet-server.net ([209.51.153.26]:46273 "EHLO
	detroit.securenet-server.net") by vger.kernel.org with ESMTP
	id S932381AbWBGARU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 19:17:20 -0500
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: "Michael Kerrisk" <mtk-manpages@gmx.net>
Subject: Re: man-pages-2.22 is released
Date: Mon, 6 Feb 2006 16:17:12 -0800
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
References: <200602061451.37028.jbarnes@virtuousgeek.org> <28306.1139266765@www031.gmx.net>
In-Reply-To: <28306.1139266765@www031.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602061617.12713.jbarnes@virtuousgeek.org>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - detroit.securenet-server.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - virtuousgeek.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, February 6, 2006 2:59 pm, Michael Kerrisk wrote:
> > Wouldn't it be easier for you to keep them up to date if sections 2,
> > 4, and parts of 5 were included in the kernel source tree? 
> > Documentation updates could be enforced as part of the patch
> > process--all you'd have to do is NAK patches that modified userland
> > interfaces if they didn't contain documentation updates (and I'm
> > sure others would help you with that task).
>
> Life is not so simple, as I think we discussed when you made
> a similar comment after my man-pages-2.08 release.  Maybe the
> system can be improved still.  Currently Andrew Morton is being
> rather good about CCing me on patches that are likely to need
> man-pages changes.  (Thanks Andrew!)

Yeah, vigilance is key; maybe I'm wrong that putting the kernel stuff 
into the kernel tree would help, but it's worth a try, don't you 
think? :)

> > Likewise with the glibc stuff.  Doesn't it belong with the glibc
> > project? Wouldn't that make more sense, both from a packaging and
> > maintenance perspective?
>
> Not really -- glibc has a differnt philosophy about documentation
> (less focus on historical information and less comparison
> with other Unix systems, as far as I can see), and uses info(1),
> not man(1).

Oh yeah, forgot about that...  I guess man vs. info and glibc development 
philosophy is for another thread.

Thanks,
Jesse
