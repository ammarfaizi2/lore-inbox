Return-Path: <linux-kernel-owner+w=401wt.eu-S1759434AbWLJCI2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434AbWLJCI2 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 21:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759445AbWLJCI2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 21:08:28 -0500
Received: from ms-smtp-02.ohiordc.rr.com ([65.24.5.136]:60075 "EHLO
	ms-smtp-02.ohiordc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759434AbWLJCI1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 21:08:27 -0500
Subject: Re: [PATCH] usbhid quirks for macbook(pro) (was: Re: Fwd: Re:
	[linux-usb-devel] usb initialization order (usbhid	vs. appletouch))
From: Joseph Fannin <jhf@columbus.rr.com>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Oliver Neukum <oliver@neukum.name>,
       Sergey Vlasov <vsu@altlinux.ru>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1165598367.19187.18.camel@localhost>
References: <1161856438.5214.2.camel@no.intranet.wo.rk>
	 <1162054576.3769.15.camel@localhost> <200610282043.59106.oliver@neukum.org>
	 <200610282055.29423.oliver@neukum.name> <1162067266.4044.2.camel@localhost>
	 <20061030101202.GB9265@nineveh.rivenstone.net>
	 <1165598367.19187.18.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 09 Dec 2006 21:08:09 -0500
Message-Id: <1165716489.27637.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 18:19 +0100, Soeren Sonnenburg wrote:

> ok, this patch was now in the mactel svn repository since about a month
> and I've never ever seen a report about it failing. Also I asked on the
> mailinglist for anyone having problems with that and got no answer,
> execpt Joseph, the problem you have been seeing might have been that
> one:
> 
> http://www.mail-archive.com/mactel-linux-devel@lists.sourceforge.net/msg00129.html
> 
> I would therefore hope it can be applied and thus appear in .20. I am
> attaching the version that is now in mactel-svn (which also includes
> geyser4 support).

    I've since gotten my Macbook's trackpad working with the Appletouch
driver also, now, so make that no problems, please.

    I don't know what the problems I was seeing were anymore, but I
think it was mostly the difficulty in getting it set up.  I understand
that this should help fix that, and wish I hadn't tried to hold it up!

--
Joseph Fannin
jfannin@gmail.com | jhf@columbus.rr.com
