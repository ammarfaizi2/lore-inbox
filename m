Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbUAZE0h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 23:26:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265494AbUAZE0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 23:26:34 -0500
Received: from mail.gmx.de ([213.165.64.20]:27627 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265457AbUAZE0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 23:26:32 -0500
X-Authenticated: #12437197
Date: Mon, 26 Jan 2004 06:26:32 +0200
From: Dan Aloni <da-x@gmx.net>
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Cooperative Linux
Message-ID: <20040126042631.GA401@callisto.yi.org>
References: <20040125193518.GA32013@callisto.yi.org> <40148C1C.5040102@vgertech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40148C1C.5040102@vgertech.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 26, 2004 at 03:40:12AM +0000, Nuno Silva wrote:
> Hi!
> 
> Dan Aloni wrote:
> >Hello fellow developers, kernel hackers, and open source contributors,
> >
> >Cooperative Linux is a port of the Linux kernel which allows it 
> >to run cooperatively under other operating systems in ring0 without 
> >hardware emulation, based on very minimal changes in the architecture 
> >dependent code and almost no changes in functionality.
> >
> >The bottom line is that it allows us to run Linux on an unmodified
> >Windows 2000/XP system in a practical way (the user just launches 
> 
> Very nice! Can we run two (or more) instances of Linux at the same time?

Yes, it would be possible.

> When will you release a linux-as-host patch? :-)

I can't say exactly when, but several people volunteered to work on this. 

-- 
Dan Aloni
da-x@gmx.net
