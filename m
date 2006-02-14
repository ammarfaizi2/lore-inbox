Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030221AbWBNDWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030221AbWBNDWS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:22:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBNDWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:22:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16019 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750962AbWBNDWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:22:17 -0500
Date: Mon, 13 Feb 2006 19:21:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Jones <davej@redhat.com>
Cc: avuton@gmail.com, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc3
Message-Id: <20060213192105.7e6da072.akpm@osdl.org>
In-Reply-To: <20060214025443.GB8405@redhat.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org>
	<3aa654a40602130231p1c476e99paa986fa198951839@mail.gmail.com>
	<20060213023925.2b950eea.akpm@osdl.org>
	<3aa654a40602130251t174a5e4bg28a52a147cc9b2cf@mail.gmail.com>
	<20060213025603.2014f9bd.akpm@osdl.org>
	<20060213184442.464f0fc6.akpm@osdl.org>
	<20060214025443.GB8405@redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> wrote:
>
>   > argh.   The fix for this oops is still languishing in David's tree.
> 
>  I was waiting for it to turn up in an -mm release first to be
>  sure everything was ok.

If we're at -rc<late> and we have a fix in hand and we know we will want
that fix in 2.6.x, I don't think there's a lot of point in hanging around -
slam it in asap, give it the most exposure possible.
