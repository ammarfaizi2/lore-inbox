Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbUBZRCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 12:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbUBZRCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 12:02:06 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:26375 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262825AbUBZRBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 12:01:54 -0500
Date: Thu, 26 Feb 2004 17:53:18 +0100
From: Willy Tarreau <willy@w.ods.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.4] /proc/kcore is a random generator ?
Message-ID: <20040226165318.GA4377@alpha.home.local>
References: <200402181337.i1IDbsXU010467@hera.kernel.org> <20040226161637.GA4201@alpha.home.local> <Pine.LNX.4.53.0402261148080.3152@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0402261148080.3152@chaos>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 11:50:27AM -0500, Richard B. Johnson wrote:
 
> Well with 'older' utilities on 2.4.24, I always get '0' with `du`!

that's what I've always been used to, too. I noticed it first because a
classical "du -sc /" was 500 MB bigger than it ought to be.

> Probably moon-phase.

I didn't think about this, but you may be right :-)

Cheers,
Willy

