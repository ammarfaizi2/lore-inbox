Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261597AbVGDBcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261597AbVGDBcy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 21:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVGDBcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 21:32:54 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:26183 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261597AbVGDBco convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 21:32:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EQVSM8xNa+ckA0leDOTmLV6Kqgu+DNE8ABPf5v2N0djCNfd/7YCYqAWIrbnArDqFSNn5joP6tDIVI0nWNWqJopYiGqzDgNTHcOnkSOPAd0iGeSDUmDv9l9iJnCQOMtvBhMfc/epfC7BrTZXoa2vZFStjwjLEPd7rLB/99jAD+xA=
Message-ID: <9a8748490507031832546f383a@mail.gmail.com>
Date: Mon, 4 Jul 2005 03:32:43 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Alejandro Bonilla <abonilla@linuxwireless.org>
Subject: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested? (Accelerometer))
Cc: Dave Hansen <dave@sr71.net>, Henrik Brix Andersen <brix@gentoo.org>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/3/05, Alejandro Bonilla <abonilla@linuxwireless.org> wrote:
> 
> BTW, we are on irc.freenode.org in #hdaps If anyone is interested.
> 
> .Alejandro
> 
I just had a nice chat with the guys there and we got some
improvements made by them and us merged up. And I /think/ we agreed
that I'll maintain the driver, merge fixes/features etc and eventually
try to get it merged.

Currently the driver loads, initializes the accelerometer and we can
read data from it.
I'll be working on adding sysfs stuff to it tomorrow so it's generally
useful (at least for monitoring things - not yet for parking disk
heads).
Once I've got the sysfs stuff sorted I'll publish a new version.

The most recent version of the driver is currently at
http://lemonshop.dk/ibm_hpaps/ (note: this is most likely not going to
be the permanent home of this driver, but it's where it lives for
now).

Patches are welcome at jesper.juhl@gmail.com


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
