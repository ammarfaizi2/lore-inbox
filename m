Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263153AbVG3ULj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263153AbVG3ULj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 16:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263140AbVG3UJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 16:09:10 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:38831 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263153AbVG3UIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 16:08:51 -0400
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
From: Lee Revell <rlrevell@joe-job.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20050730195116.GB9188@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de>
	 <1122678943.9381.44.camel@mindpipe>
	 <20050730120645.77a33a34.Ballarin.Marc@gmx.de>
	 <1122746718.14769.4.camel@mindpipe>  <20050730195116.GB9188@elf.ucw.cz>
Content-Type: text/plain
Date: Sat, 30 Jul 2005 16:08:47 -0400
Message-Id: <1122754127.14769.21.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-07-30 at 21:51 +0200, Pavel Machek wrote:
> > I think this is a good argument for leaving HZ at 1000 until some of
> > these userspace bugs are fixed.
> 
> WTF? HZ=1000 eats energy like crazy. artsd eats energy like crazy. And
> you advocate breaking kernel because artsd is broken?!

Also as Con's numbers demonstrate, from the interactivity POV it is you
who are breaking the kernel.

Lee

