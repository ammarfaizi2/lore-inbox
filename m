Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTESXQA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 19:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263358AbTESXQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 19:16:00 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:15626 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S263355AbTESXP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 19:15:59 -0400
Date: Tue, 20 May 2003 01:28:56 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Recent changes to sysctl.h breaks glibc
Message-ID: <20030519232856.GA533@win.tue.nl>
References: <20030519165623.GA983@mars.ravnborg.org> <Pine.LNX.4.44.0305191039320.16596-100000@home.transmeta.com> <babhik$sbd$1@cesium.transmeta.com> <m1d6ie37i8.fsf@frodo.biederman.org> <3EC95B58.7080807@zytor.com> <1053382815.29227.29.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053382815.29227.29.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 11:20:16PM +0100, Alan Cox wrote:

> > seem to think that ABIs remain fixed.
> 
> Because with a few deep system stuff exceptions they do, although they
> certainly extend. Rogue for 0.98.5 still runs on 2.4.21 (although you
> may have fun finding libc2.2.2)

ftp://ftp.win.tue.nl/pub/linux-local/libcbin/libc-2.2.2/ ?

