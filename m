Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262942AbTDVGHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 02:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTDVGHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 02:07:15 -0400
Received: from [203.94.130.164] ([203.94.130.164]:9403 "EHLO bad-sports.com")
	by vger.kernel.org with ESMTP id S262942AbTDVGHO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 02:07:14 -0400
Date: Tue, 22 Apr 2003 16:00:50 +1000 (EST)
From: Brett <generica@email.com>
X-X-Sender: brett@bad-sports.com
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.68{,-bk1,-bk2} refuses to boot
In-Reply-To: <20030422060021.GA19139@lug-owl.de>
Message-ID: <Pine.LNX.4.44.0304221558530.29695-100000@bad-sports.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Apr 2003, Jan-Benedict Glaw wrote:

> On Tue, 2003-04-22 15:31:13 +1000, Brett <generica@email.com>
> wrote in message <Pine.LNX.4.44.0304221526400.29695-100000@bad-sports.com>:
> > 
> > Hey,
> > 
> > topic says it all
> > blank screen after grub loads the kernel
> 
> You possibly forgot CONFIG_INPUT=y and CONFIG_VT=y or so...
> 
> MfG, JBG
> 
> 

Nope

both are =y in the .config

the only _changed_ config item from my working .57 to my non-working .58 
(aside from new config entries which are unset) is CONFIG_DEVPTS_FS=y, 
because of my devfs usage

thanks anyway

	/ Brett

