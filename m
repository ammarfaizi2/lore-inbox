Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267998AbUJJBJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267998AbUJJBJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 21:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUJJBJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 21:09:19 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:16057 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267998AbUJJBJP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 21:09:15 -0400
Subject: Re: [ANNOUNCE] Linux 2.6 Real Time Kernel
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xbrfb8js6.fsf@mru.ath.cx>
References: <41677E4D.1030403@mvista.com> <yw1xk6u0hw2m.fsf@mru.ath.cx>
	 <1097356829.1363.7.camel@krustophenia.net> <yw1xis9ja82z.fsf@mru.ath.cx>
	 <1097365941.1363.31.camel@krustophenia.net> <yw1xfz4n8mkh.fsf@mru.ath.cx>
	 <1097369142.1367.2.camel@krustophenia.net>  <yw1xbrfb8js6.fsf@mru.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1097370554.1367.8.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 09 Oct 2004 21:09:15 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-10-09 at 21:05, Måns Rullgård wrote:
> > OK, first bug: I lost my PS/2 keyboard, and had to reboot to get it
> > back.  Unplugging and replugging it made Num Lock work again, but the
> > system did not respond to the keyboard at all.  USB mouse continued to
> > work fine.
> 
> I lost my keyboard as well, though only in X, but I figured that could
> be caused by some changes to the input layer that went in between
> 2.6.9-rc2 and -rc3.  My synaptics touchpad also stopped working
> properly.  USB keyboard and mouse worked properly.

Looks like the same areas that were problematic with the VP kernel will
be an issue here.  I suspect many of the fixes already exist in Ingo's
patch or in -mm.

I think my keyboard issue is different because it worked fine, then I
lost it suddenly.

Lee

