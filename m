Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVI0ONu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVI0ONu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 10:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbVI0ONu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 10:13:50 -0400
Received: from xproxy.gmail.com ([66.249.82.192]:25192 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750942AbVI0ONt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 10:13:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=tIWyCFz4CsuwvX+x0hZG/h+6tHZwaMJkcOPPEfvwgol3yASYiHcxHCsXb8bqYgW7FY3fs9XQR7fTBccf/BAZtFEnSnWQyr524MLAJv8gIccMeV63blVkH/iCJIyPExrjsuLR7y28anD5+jCRfBwOl3iSM0piVHA9WxREgsiI+8U=
Date: Tue, 27 Sep 2005 10:10:20 -0400
From: Florin Malita <fmalita@gmail.com>
To: Eric Paris <eparis@redhat.com>
Cc: fubar@us.ibm.com, nsxfreddy@gmail.com, akpm@osdl.org, davem@davemloft.net,
       ctindel@users.sourceforge.net, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, bonding-devel@lists.sourceforge.net
Subject: Re: [Bonding-devel] Re: [PATCH] channel bonding: add support for
 device-indexed parameters
Message-Id: <20050927101020.6e0b2203.fmalita@gmail.com>
In-Reply-To: <1127829269.4560.4.camel@localhost.localdomain>
References: <20050927012444.be5d5311.fmalita@gmail.com>
	<200509270711.j8R7BunP014387@death.nxdomain.ibm.com>
	<20050927094055.7953a832.fmalita@gmail.com>
	<1127829269.4560.4.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.2 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 09:54:29 -0400
Eric Paris <eparis@redhat.com> wrote:

> It dos work with RHEL3.  In modules.conf you just need
[...]
> You can add your mode and mii_mon and such on the options lines.  It
> does work I've used it.

Verified - I completely missed "-o" functionality in insmod & friends.

Sorry for the noise, I'll crawl back under my rock now :)
