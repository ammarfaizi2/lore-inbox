Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265577AbUBBCml (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 21:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbUBBCml
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 21:42:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50823 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265577AbUBBCmj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 21:42:39 -0500
Message-ID: <401DB912.5030602@pobox.com>
Date: Sun, 01 Feb 2004 21:42:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 EXTRAVERSION is bad for -rcX-bkY's
References: <20040202020053.GB21554@earth.solarsys.private>
In-Reply-To: <20040202020053.GB21554@earth.solarsys.private>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark M. Hoffman wrote:
> E.g.
> 
> EXTRAVERSION for 2.6.2-rc3-bk1 is "-bk1"; it should be "-rc3-bk1" no?
> 
> http://www.kernel.org/diff/diffview.cgi?file=%2Fpub%2Flinux%2Fkernel%2Fv2.6%2Fsnapshots%2Fpatch-2.6.2-rc3-bk1.bz2;z=1


Yeah, that definitely sounds like a bug...

	Jeff



