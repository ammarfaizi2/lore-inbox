Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUHOIN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUHOIN0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 04:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266538AbUHOIN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 04:13:26 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:43024 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S265691AbUHOINZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 04:13:25 -0400
Date: Sun, 15 Aug 2004 10:15:56 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andres Salomon <dilinger@voxel.net>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] don't delete debian directory in official debian builds
Message-ID: <20040815081556.GA20555@mars.ravnborg.org>
Mail-Followup-To: Andres Salomon <dilinger@voxel.net>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <1092512343.3971.23.camel@spiral.internal> <20040815071559.GB7182@mars.ravnborg.org> <1092556593.20551.14.camel@toaster.hq.voxel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092556593.20551.14.camel@toaster.hq.voxel.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 03:56:32AM -0400, Andres Salomon wrote:
> > 
> > Preference to 1).
> 
> I'm not quite sure what you mean w/ #1.  You want Debian, which has used
> the debian/ subdirectory for years, to use something else for its kernel
> packages?

Let the kernel use a directory named 'deb' to match the deb-pkg target.

	Sam
