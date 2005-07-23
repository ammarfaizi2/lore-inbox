Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262321AbVGWDJX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbVGWDJX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 23:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262324AbVGWDJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 23:09:23 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21404 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262321AbVGWDJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 23:09:22 -0400
Subject: Re: Giving developers clue how many testers verified certain
	kernel version
From: Lee Revell <rlrevell@joe-job.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Cc: Blaisorblade <blaisorblade@yahoo.it>, LKML <linux-kernel@vger.kernel.org>,
       Andrian Bunk <bunk@stusta.de>, "H. Peter Anvin" <hpa@zytor.com>,
       torvalds@osdl.org
In-Reply-To: <42E1986B.8070202@linuxwireless.org>
References: <200507230244.11338.blaisorblade@yahoo.it>
	 <42E1986B.8070202@linuxwireless.org>
Content-Type: text/plain
Date: Fri, 22 Jul 2005 23:09:19 -0400
Message-Id: <1122088160.6510.7.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-22 at 20:07 -0500, Alejandro Bonilla wrote:
> I will get flames for this, but my laptop boots faster and sometimes 
> responds faster in 2.4.27 than in 2.6.12. Sorry, but this is the fact 
> for me. IBM T42.

Sorry dude, but there's just no way that any automated process can catch
these.

You will have to provide a detailed bug report (with numbers) like
everyone else so we can fix it.  "Waiting for it to fix itself" is the
WORST thing you can do.

If you find a regression vs. an earlier kernel, please assume that
you're the ONLY one to notice it and respond accordingly.

Lee

