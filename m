Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263788AbTKXPvI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263796AbTKXPvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:51:07 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:44968 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S263788AbTKXPvC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:51:02 -0500
Date: Mon, 24 Nov 2003 07:50:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: data from kernel.bkbits.net
Message-ID: <20031124155034.GA13896@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Ricky Beam <jfbeam@bluetronic.net>,
	"H. Peter Anvin" <hpa@zytor.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <3FC1B48B.8090403@zytor.com> <Pine.GSO.4.33.0311241033220.13188-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0311241033220.13188-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 24, 2003 at 10:43:34AM -0500, Ricky Beam wrote:
> On Sun, 23 Nov 2003, H. Peter Anvin wrote:
> >Larry McVoy wrote:
> >> ...
> >
> >Looks more like a 3Ware driver bug to me.  Hard to say for sure, though.
> 
> Or simply a dead drive. (or a "dirty" cable -- try re-plugging that one.)

Thanks for the advice, but this drive has been plugged into 3 different
controllers on different machines using different cables.  Both this drive
and the backup drive refused to fsck clean (they had a lot of errors with
directory corruption problems).  

It is not a dirty cable or a bad controller, I've been building and 
debugging PC hardware for years and I know how to track down obvious
problems.

Sorry to be short but I already said that I'd eliminated this source of
error.  What did you think I was doing all weekend?
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
