Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263312AbTJZRQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 12:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTJZRQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 12:16:35 -0500
Received: from linuxhacker.ru ([217.76.32.60]:9437 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263312AbTJZRQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 12:16:33 -0500
Date: Sun, 26 Oct 2003 19:13:49 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: ndiamond@wta.att.ne.jp, vitaly@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
Message-ID: <20031026171348.GA14147@linuxhacker.ru>
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9BA98B.20408@namesys.com> <200310261259.h9QCxhWv004314@car.linuxhacker.ru> <3F9BB870.1010500@namesys.com> <20031026123925.GA6412@linuxhacker.ru> <3F9BF5BE.9030601@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9BF5BE.9030601@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Oct 26, 2003 at 07:26:38PM +0300, Hans Reiser wrote:
> >>bad shape is concerned, from the user's point of view it either works or 
> >>it doesn't.
> >Sure. And in modern desktop world it does not work (if SMART does not want 
> >to
> >do it).
> I don't understand what SMART has to do with it.  I was talking about a 
> patch is either ready for use, or it isn't, and "almost ready" is worthless.

Ah. Last time I checked, patch was ready to use.
But it is not strictly necessary, the reason of the patch was to mark bad blocks
in mounted filesystems "on the fly". Everything else should be handled
by reiserfsprogs anyway. Without reiserfsprogs support (which was ready too),
it is worthless.

Bye,
    Oleg
