Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751158AbWCTQ23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158AbWCTQ23 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWCTQ23
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:28:29 -0500
Received: from smtp10.wanadoo.fr ([193.252.22.21]:6713 "EHLO smtp10.wanadoo.fr")
	by vger.kernel.org with ESMTP id S1751219AbWCTQ21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:28:27 -0500
X-ME-UUID: 20060320162825642.9CC3424001A3@mwinf1012.wanadoo.fr
Subject: Re: Lindent and coding style
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Li Yang-r58472 <LeoLi@freescale.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <441ED656.7050005@gmail.com>
References: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>
	 <1142865404.20050.29.camel@localhost.localdomain>
	 <441EC157.2030103@gmail.com> <1142871150.22772.351.camel@capoeira>
	 <441ED656.7050005@gmail.com>
Content-Type: text/plain
Message-Id: <1142872100.22772.355.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 20 Mar 2006 17:28:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 17:21, Jiri Slaby wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Xavier Bestel napsal(a):
> > On Mon, 2006-03-20 at 15:51, Jiri Slaby wrote:
> >>> It should produce suitable output. Do you have examples of where it
> >>> produces space indentation and you expect tabs ?
> >> As far as I know, it produces:
> >> <tab>	if (very long condition &&
> >> <tab>   ssss2nd condition)...
> >> where ssss are four spaces. Maybe this is considered as well formed at all, but
> >> I indent 3 tabs in this case.
> > 
> > Does that mean your tabs are 2-chars wide ? I think Linus stated that
> > tabs should be 8-chars wide, that should be somewhere in the
> > CodingStyle.
> Nope, you maybe misunderstood me. Tab is 8 chars wide, but lindent do 4 spaces
> on line after `if' if the condition continues on the next line. Then, I wrote I
> do 2 tabs (16 chars) instead of 4-lindent spaces.

My  bad. I thought your 3 tabs were equivalent to 1 tab + 4 spaces.



