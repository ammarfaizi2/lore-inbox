Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWCTQM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWCTQM6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbWCTQM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:12:56 -0500
Received: from smtp1.wanadoo.fr ([193.252.22.30]:61926 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S964944AbWCTQMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:12:42 -0500
X-ME-UUID: 20060320161240695.A9D641C00100@mwinf0106.wanadoo.fr
Subject: Re: Lindent and coding style
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Li Yang-r58472 <LeoLi@freescale.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <441EC157.2030103@gmail.com>
References: <9FCDBA58F226D911B202000BDBAD4673054C311B@zch01exm40.ap.freescale.net>
	 <1142865404.20050.29.camel@localhost.localdomain>
	 <441EC157.2030103@gmail.com>
Content-Type: text/plain
Message-Id: <1142871150.22772.351.camel@capoeira>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Mon, 20 Mar 2006 17:12:30 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 15:51, Jiri Slaby wrote:
> > It should produce suitable output. Do you have examples of where it
> > produces space indentation and you expect tabs ?
> As far as I know, it produces:
> <tab>	if (very long condition &&
> <tab>   ssss2nd condition)...
> where ssss are four spaces. Maybe this is considered as well formed at all, but
> I indent 3 tabs in this case.

Does that mean your tabs are 2-chars wide ? I think Linus stated that
tabs should be 8-chars wide, that should be somewhere in the
CodingStyle.

	Xav


