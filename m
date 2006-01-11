Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1160998AbWAKGvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1160998AbWAKGvP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161000AbWAKGvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:51:15 -0500
Received: from mail.kroah.org ([69.55.234.183]:44434 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1160998AbWAKGvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:51:14 -0500
Date: Tue, 10 Jan 2006 22:22:32 -0800
From: Greg KH <greg@kroah.com>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I would implement 'ksh' like this if there weren't any ksh before
Message-ID: <20060111062232.GA3954@kroah.com>
References: <873bk0wsba.dancerj%dancer@netfort.gr.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873bk0wsba.dancerj%dancer@netfort.gr.jp>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2006 at 01:55:05PM +0900, Junichi Uekawa wrote:
> 
> If noone realized this, this is on the 'this is a joke' category, but
> available as part of binfmtc[1] package, which provides mostly useless
> plethora of binfmt-misc related tools.
> 
> [1] http://www.netfort.gr.jp/~dancer/software/binfmtc.html.en

Yeah, it might be a joke, but a nice one to keep in the toolbox for when
it's impossible to get systemtap up and working due to libelf issues :)

Nice hack, I like it...

greg k-h
