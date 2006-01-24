Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750779AbWAXWVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750779AbWAXWVL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 17:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbWAXWVL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 17:21:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63654 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750779AbWAXWVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 17:21:09 -0500
Date: Tue, 24 Jan 2006 17:20:44 -0500
From: Dave Jones <davej@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@osdl.org>, rjw@sisk.pl, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] swsusp: userland interface (rev 2)
Message-ID: <20060124222044.GG2449@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
	rjw@sisk.pl, linux-kernel@vger.kernel.org
References: <200601240929.37676.rjw@sisk.pl> <20060124131312.0545262d.akpm@osdl.org> <20060124213010.GA1602@elf.ucw.cz> <20060124135843.739481e7.akpm@osdl.org> <20060124221426.GB1602@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124221426.GB1602@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 11:14:26PM +0100, Pavel Machek wrote:

 > suspending programs are quite closely tied to the kernel. I think it
 > is reasonable to expect users to have matching version of kernel and
 > userland-swsusp tools

    _        _    ____  ____   ____  ____ _   _ _   _ _   _ _   _
   / \      / \  |  _ \|  _ \ / ___|/ ___| | | | | | | | | | | | |
  / _ \    / _ \ | |_) | |_) | |  _| |  _| |_| | |_| | |_| | |_| |
 / ___ \  / ___ \|  _ <|  _ <| |_| | |_| |  _  |  _  |  _  |  _  |
/_/   \_\/_/   \_\_| \_\_| \_\\____|\____|_| |_|_| |_|_| |_|_| |_|

Someone please stop this madness..

		Dave

