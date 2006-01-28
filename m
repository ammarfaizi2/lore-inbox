Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751380AbWA1EEk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380AbWA1EEk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 23:04:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWA1EEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 23:04:40 -0500
Received: from xenotime.net ([66.160.160.81]:40413 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751380AbWA1EEk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 23:04:40 -0500
Date: Fri, 27 Jan 2006 20:04:56 -0800
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Andrew Morton <akpm@osdl.org>
Cc: bart@samwel.tk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Fix overflow issues with sysctl values in
 centiseconds/seconds
Message-Id: <20060127200456.113f9756.rdunlap@xenotime.net>
In-Reply-To: <20060127195539.6ffc3d3a.akpm@osdl.org>
References: <43DADB03.7080606@samwel.tk>
	<20060127195539.6ffc3d3a.akpm@osdl.org>
Organization: YPO4
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006 19:55:39 -0800 Andrew Morton wrote:

> Bart Samwel <bart@samwel.tk> wrote:
> >
> >  Here's a threesome of patches
> >
> 
> All of which were space-stuffed by your (mozilla-derived) email client and
> hence are unusable by users of non-MS-wannabe email clients.  They may also
> be unusable by users of mozilla-based email clients, too - I don't know.
> 
> As far as I know there's no way to prevent mailnews-derived mail clients
> from performing space-stuffing.  I've had a bug report in against it for at
> least two years and all they've done is fartarse around with it.
> 
> IOW: please switch mail clients or use text/plain attachments.

Someone kept saying that tbird would work and I kept asking how.
What I finally got was:

a.  enable html-formatted email (unintuirive, I had disabled it)
b.  for the body text, select Fixed Width
c.  copy-and-paste the patch

I tested it one time and it worked.
But as long as Andrew accepts text/plain attachments, that
works for him.  Makes it difficult to review them in some
mail clients...

---
~Randy
