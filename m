Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261880AbVDCTos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVDCTos (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 15:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261882AbVDCTor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 15:44:47 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:25161 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261880AbVDCToc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 15:44:32 -0400
Date: Sun, 3 Apr 2005 21:45:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ajay Patel <patela@gmail.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [KBUILD] Bug in make deb-pkg when using seperate source and object directories
Message-ID: <20050403194548.GD11347@mars.ravnborg.org>
References: <20050313060940.GB7828@mythryan2.michonline.com> <90f56e4805031411593fd945f2@mail.gmail.com> <20050320002800.GJ5318@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050320002800.GJ5318@mythryan2.michonline.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2005 at 07:28:00PM -0500, Ryan Anderson wrote:
> On Mon, Mar 14, 2005 at 11:59:26AM -0800, Ajay Patel wrote:
> > I had a similar problem building binrpm-pkg.
> > Try following patch. It worked for me.
> 
> My problem wasn't actually resolved by this - the make in builddeb still
> caused issues.
> 
> So, a normal, unified diff form of the patch, fixed up, is attached.
> 
> Signed-off-By: Ryan Anderson <ryan@michonline.com>

Applied.

	Sam
