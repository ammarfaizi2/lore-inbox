Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbTJ0MyT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 07:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbTJ0MyT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 07:54:19 -0500
Received: from mail.comset.net ([213.172.0.3]:51897 "EHLO mail.comset.net")
	by vger.kernel.org with ESMTP id S261686AbTJ0MyS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 07:54:18 -0500
From: Vitaly Fertman <vitaly@namesys.com>
Organization: NAMESYS
To: Oleg Drokin <green@linuxhacker.ru>, Hans Reiser <reiser@namesys.com>
Subject: Re: Blockbusting news, results end
Date: Mon, 27 Oct 2003 15:44:37 +0300
User-Agent: KMail/1.5.1
Cc: ndiamond@wta.att.ne.jp, linux-kernel@vger.kernel.org
References: <346101c39b9e$35932680$24ee4ca5@DIAMONDLX60> <3F9C107D.3040401@namesys.com> <20031026190707.GC14147@linuxhacker.ru>
In-Reply-To: <20031026190707.GC14147@linuxhacker.ru>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200310271543.15160.vitaly@namesys.com>
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 October 2003 22:07, Oleg Drokin wrote:
> Hello!
>
> On Sun, Oct 26, 2003 at 09:20:45PM +0300, Hans Reiser wrote:
> > >Everything else should be handled
> > >by reiserfsprogs anyway. Without reiserfsprogs support (which was ready
> > >too),
> >
> > If it isn't included in what we release, the job isn't done, and the
> > work is useless.  I don't know why people think that if they have
> > written a patch that they and only they know where to get and how to
> > apply, something useful has been done.
>
> The kernel patch was handed to Vitaly with instructions on how to apply and
> how to use. (And Vitaly added necessary support to reiserfsprogs, without
> which this patch would be useless)
> Now the decision of whenever to release this piece of code (the patch and
> the reiserfsprogs parts) is not mine.

The code needed to be tested first before releasing, it is done by now and
I am about to put on our ftp site 3.6.12-pre1 release with this bad block support.

-- 
Thanks,
Vitaly Fertman


