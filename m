Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbULZQkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbULZQkc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 11:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbULZQkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 11:40:32 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:14210 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261700AbULZQk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 11:40:28 -0500
Date: Sun, 26 Dec 2004 16:40:51 +0000
From: Karel Kulhavy <clock@twibright.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: description of struct sockaddr
Message-ID: <20041226164051.GA5529@beton.cybernet.src>
References: <20041123214300.GB2147@beton.cybernet.src> <Pine.LNX.4.53.0411232309360.23119@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0411232309360.23119@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2004 at 11:11:31PM +0100, Jan Engelhardt wrote:
> >Hello
> >
> >man netdevice talks about struct sockaddr, but neither describes it,
> >nor provides a link to descriptio, nor the "SEE ALSO" items
> >(ip(7), proc(7), rnetlink(7)) provide the necessary information.
> >
> >"The hardware address is specified in a struct sockaddr".
> 
> I don't think so. The hardware address is, well, specific to the hardware (like
> Ethernet, for example). IP/TCP/UDP however is not limited to Ethernet. And
> 'sockaddr' clearly is something that does not deal with hardware.

It is a sentence from man netdevice. Should I send a bugreport to the manpage
maintainer?

Cl<
