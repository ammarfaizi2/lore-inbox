Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261503AbVBWRSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261503AbVBWRSP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 12:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbVBWRRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 12:17:49 -0500
Received: from mail.suse.de ([195.135.220.2]:43659 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261505AbVBWROi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 12:14:38 -0500
Subject: Re: [darcs-users] Re: [BK] upgrade will be needed
From: Andreas Gruenbacher <agruen@suse.de>
To: zander@kde.org
Cc: Andrea Arcangeli <andrea@suse.de>, darcs-users@darcs.net, lm@bitmover.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050221194557.GA23251@factotummedia.nl>
References: <20050214020802.GA3047@bitmover.com>
	 <200502172105.25677.pmcfarland@downeast.net> <421551F5.5090005@tupshin.com>
	 <20050218090900.GA2071@opteron.random>
	 <bc647aafb53842b58dd0279161fb48e0@spy.net>
	 <buosm3q5v5y.fsf@mctpc71.ucom.lsi.nec.co.jp>
	 <20050221155306.GU7247@opteron.random>
	 <20050221194557.GA23251@factotummedia.nl>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1109178868.12834.66.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 23 Feb 2005 18:14:29 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-21 at 20:45, zander@kde.org wrote:
> CVS was pretty good at keeping files sane, but I'll go for a solution that
> completely sidesteps said problem any day.

One way to get the benefits of both worlds would be to keep an
additional history of changes (in whatever form) that allows to rebuild
the ,v files.

