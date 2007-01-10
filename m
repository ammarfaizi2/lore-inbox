Return-Path: <linux-kernel-owner+w=401wt.eu-S932639AbXAJBnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639AbXAJBnV (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXAJBnV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:43:21 -0500
Received: from MAIL.13thfloor.at ([213.145.232.33]:56019 "EHLO
	MAIL.13thfloor.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932637AbXAJBnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:43:20 -0500
Date: Wed, 10 Jan 2007 02:43:19 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Jean Delvare <khali@linux-fr.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
       Andy Whitcroft <apw@shadowen.org>, Olaf Hering <olaf@aepfle.de>
Subject: Re: .version keeps being updated
Message-ID: <20070110014319.GA7145@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Jean Delvare <khali@linux-fr.org>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>, Olaf Hering <olaf@aepfle.de>
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <20070109133121.194f3261.akpm@osdl.org> <Pine.LNX.4.64.0701091520280.3594@woody.osdl.org> <20070109152534.ebfa5aa8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109152534.ebfa5aa8.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 03:25:34PM -0800, Andrew Morton wrote:
> On Tue, 9 Jan 2007 15:21:51 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > On Tue, 9 Jan 2007, Andrew Morton wrote:
> > > 
> > > > This new behavior of the kernel build system is likely to
> > > > make developers angry pretty quickly.
> > > 
> > > That might motivate them to fix it ;)
> > 
> > Actually, how about just removing the incrementing version count
> > entirely?
>
> I use it pretty commonly to answer the question "did I remember to
> install that new kernel I just built before I rebooted"? By comparing
> `uname -a' with $TOPDIR/.version.

second that!

please do not remove this useful 'debug' feature :)

TIA,
Herbert

