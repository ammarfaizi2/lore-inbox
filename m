Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVDGDeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVDGDeW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 23:34:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVDGDeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 23:34:22 -0400
Received: from smtp.istop.com ([66.11.167.126]:3785 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S261233AbVDGDeS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 23:34:18 -0400
From: Daniel Phillips <phillips@istop.com>
To: Martin Pool <mbp@sourcefrog.net>
Subject: Re: Kernel SCM saga..
Date: Wed, 6 Apr 2005 23:35:25 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <20050406193911.GA11659@stingr.stingr.net> <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
In-Reply-To: <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504062335.25732.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 21:40, Martin Pool wrote:
> On Wed, 06 Apr 2005 23:39:11 +0400, Paul P Komkoff Jr wrote:
> > http://bazaar-ng.org/
>
> I'd like bazaar-ng to be considered too.  It is not ready for adoption
> yet, but I am working (more than) full time on it and hope to have it
> be usable in a couple of months.
>
> bazaar-ng is trying to integrate a lot of the work done in other systems
> to make something that is simple to use but also fast and powerful enough
> to handle large projects.
>
> The operations that are already done are pretty fast: ~60s to import a
> kernel tree, ~10s to import a new revision from a patch.

Hi Martin,

When I tried it, it took 13 seconds to 'bzr add' the 2.6.11.3 tree on a 
relatively slow machine.

Regards,

Daniel
