Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751924AbWAEHa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751924AbWAEHa2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752101AbWAEHa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:30:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:52931 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751924AbWAEHa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:30:27 -0500
Date: Thu, 5 Jan 2006 08:30:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Nick Warne <nick@linicks.net>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org, webmaster@kernel.org
Subject: Re: 2.6.14.5 to 2.6.15 patch
In-Reply-To: <20060104234106.GB15724@kroah.com>
Message-ID: <Pine.LNX.4.61.0601050829240.10161@yvahk01.tjqt.qr>
References: <200601041710.37648.nick@linicks.net> <200601042258.24888.s0348365@sms.ed.ac.uk>
 <20060104231330.GD14788@kroah.com> <200601042328.15528.s0348365@sms.ed.ac.uk>
 <Pine.LNX.4.58.0601041530000.19134@shark.he.net> <20060104234106.GB15724@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I agree.  I think that one previous -stable patch version should always
>> be listed there, even if we think that 2.6.N is stable.  :)
>
>I don't at all.  If we do that, people will assume that they need to
>wait till 2.6.N.1 before trying that kernel (as it wouldn't be "stable"
>otherwise.)  So no one will test it, to really generate the bug reports
>that we need to get to that .1 release.
>
>Or should we just throw out a .1 release with the first simple patch
>that comes along just to make the kernel.org page update properly?  I
>don't think so...
>

Or call the "2.6.X" as "2.6.X.0", so they got at least a clue that this is
becoming .1


Jan Engelhardt
-- 
