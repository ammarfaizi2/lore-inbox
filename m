Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbUKVXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbUKVXDQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbUKVXAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:00:47 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42190 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261172AbUKVW6d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:58:33 -0500
Date: Mon, 22 Nov 2004 14:58:22 -0800
From: Greg KH <greg@kroah.com>
To: Matt Heler <lkml@lpbproductions.com>
Cc: Bob van Manen <bobm75@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6. 9-gentoo-r4 migration kernel thread is using 10-60% cpu
Message-ID: <20041122225822.GF15634@kroah.com>
References: <88652ca704112212541b530efc@mail.gmail.com> <200411221455.12234.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411221455.12234.lkml@lpbproductions.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 02:55:11PM -0700, Matt Heler wrote:
> Have you made an attempt to contact the gentoo kernel team ? As it's probally 
> some patch they tacked onto there kernel release that's causing you issues.

Based on the patches that Gentoo adds to their 2.6 kernel, I really
doubt it.  There are no scheduling patches in their patchset.

You can browse the patches online, here's the link to their latest
patchset:
	http://genpatches.bkbits.net:8080/genpatches/src/genpatches-2.6-9.06?nav=index.html|src/

thanks,

greg k-h
