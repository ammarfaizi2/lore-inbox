Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTFISZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 14:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264207AbTFISZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 14:25:56 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:56584 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S263918AbTFISZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 14:25:54 -0400
Subject: Re: 2.5.70-mm6
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Maciej Soltysiak <solt@dns.toxicfilms.tv>, Andrew Morton <akpm@digeo.com>,
       LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
In-Reply-To: <46580000.1055180345@flay>
References: <20030607151440.6982d8c6.akpm@digeo.com>
	 <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv>
	 <46580000.1055180345@flay>
Content-Type: text/plain
Message-Id: <1055183971.584.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 09 Jun 2003 20:39:31 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 19:39, Martin J. Bligh wrote:
> --On Monday, June 09, 2003 19:45:58 +0200 Maciej Soltysiak <solt@dns.toxicfilms.tv> wrote:
> 
> >> . -mm kernels will be running at HZ=100 for a while.  This is because
> >>   the anticipatory scheduler's behaviour may be altered by the lower
> >>   resolution.  Some architectures continue to use 100Hz and we need the
> >>   testing coverage which x86 provides.
> >
> > The interactivity seems to have dropped. Again, with common desktop
> > applications: xmms playing with ALSA, when choosing navigating through
> > evolution options or browsing with opera, music skipps.
> > X is running with nice -10, but with mm5 it ran smoothly.
> 
> If you don't nice the hell out of X, does it work OK?

I can't appreciate much different. I've assigned shortcuts to switch
between desktops easily. Switching between desktops very fast causes
XMMS to skip sound. This also happens when dragging windows.

