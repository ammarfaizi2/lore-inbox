Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263234AbTD1LMV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 07:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTD1LMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 07:12:21 -0400
Received: from mail.zmailer.org ([62.240.94.4]:1976 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S263234AbTD1LMU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 07:12:20 -0400
Date: Mon, 28 Apr 2003 14:24:34 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Oliver Feiler <kiza@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mailinglist problems?
Message-ID: <20030428112434.GH24892@mea-ext.zmailer.org>
References: <200304281223.53020.kiza@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304281223.53020.kiza@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 28, 2003 at 12:23:44PM +0200, Oliver Feiler wrote:
> Hi,
> 
> as of late I'm getting a lot of messages with a couple of days(!) delay 
> delivered. Others from the same thread come in with no noticable delay.

  For some reason (while I was away from network),  GMX.NET  servers
  have decided that  vger.kernel.org  is mail-bombing recipients.

  There are some 30-40 recipients of  linux-kernel  list at GMX.NET,
  and there are (varying) 100-300 emails per day for each of them.

> For example
...
> Replies to this came in long before. Anyone else having these sort of problems 
> lately or should I go flame my email provider? :)

  I forwarded to you, and all other GMX.NET domain subscribers the letter
  I have already sent to   postmaster@gmx.net  -- but you (as their 
  customers) may have more weight that an external nobody, like myself...

  Most common troubles that users have are:
    - "Relaying denied"  (in its many forms
	  -->   http://vger.kernel.org/mxverify.html )
    - "Mailbox full"  (these lists are of HIGH VOLUME!)
    - DNS-lookup/connection timed out for 4+ days

  Then come various weird things, like overzealous reg-expr message
  content filters, broken MTA configurations  (don't people ever
  test that their changes do work ?),  etc...

> Bye
> -- 
> Oliver Feiler  <kiza@(kcore.de|lionking.org|gmx[pro].net)>
> http://kiza.kcore.de/    <--    homepage
> PGP-key      -->    /pgpkey.shtml
> http://kiza.kcore.de/journal/

/Matti Aarnio  -- co-postmaster of vger.kernel.org
