Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTJZTH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbTJZTH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:07:29 -0500
Received: from linuxhacker.ru ([217.76.32.60]:9702 "EHLO shrek.linuxhacker.ru")
	by vger.kernel.org with ESMTP id S263427AbTJZTH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:07:28 -0500
Date: Sun, 26 Oct 2003 21:07:07 +0200
From: Oleg Drokin <green@linuxhacker.ru>
To: Hans Reiser <reiser@namesys.com>
Cc: ndiamond@wta.att.ne.jp, vitaly@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results end
Message-ID: <20031026190707.GC14147@linuxhacker.ru>
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9BA98B.20408@namesys.com> <200310261259.h9QCxhWv004314@car.linuxhacker.ru> <3F9BB870.1010500@namesys.com> <20031026123925.GA6412@linuxhacker.ru> <3F9BF5BE.9030601@namesys.com> <20031026171348.GA14147@linuxhacker.ru> <3F9C107D.3040401@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F9C107D.3040401@namesys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Oct 26, 2003 at 09:20:45PM +0300, Hans Reiser wrote:
> >Everything else should be handled
> >by reiserfsprogs anyway. Without reiserfsprogs support (which was ready 
> >too),
> If it isn't included in what we release, the job isn't done, and the 
> work is useless.  I don't know why people think that if they have 
> written a patch that they and only they know where to get and how to 
> apply, something useful has been done.

The kernel patch was handed to Vitaly with instructions on how to apply and
how to use. (And Vitaly added necessary support to reiserfsprogs, without
which this patch would be useless)
Now the decision of whenever to release this piece of code (the patch and
the reiserfsprogs parts) is not mine.

Bye,
    Oleg
