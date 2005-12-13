Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030315AbVLMXkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030315AbVLMXkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030320AbVLMXkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:40:14 -0500
Received: from a34-mta02.direcpc.com ([66.82.4.91]:35671 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1030309AbVLMXkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:40:12 -0500
Date: Tue, 13 Dec 2005 18:39:52 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 2/2] ide/sis5513: Add support for 965 chipset
In-reply-to: <58cb370e0512131306q49cd6c3am41d5c1f46557fada@mail.gmail.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <1134517192.12502.22.camel@localhost.localdomain>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.2
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1134498192250-git-send-email-bcollins@ubuntu.com>
 <1134498254295-git-send-email-bcollins@ubuntu.com>
 <58cb370e0512131038q49271226xfe932476bb05d2d0@mail.gmail.com>
 <1134502230.12502.17.camel@localhost.localdomain>
 <58cb370e0512131157y1176bbdbk5914c67c51a9a0f0@mail.gmail.com>
 <1134506487.12502.20.camel@localhost.localdomain>
 <58cb370e0512131306q49cd6c3am41d5c1f46557fada@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-12-13 at 22:06 +0100, Bartlomiej Zolnierkiewicz wrote:
> The useful bits are here:
> http://kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-2.6.git;a=commitdiff;h=14351f8e573442e2437d4b177fa10075aaefd5c9;hp=4f1d774aadfc5a6ed1545dca180f66ab6d0f543d
> 
> The author of the patch that you are submitting confirmed that a new
> patch works for him and suggested that it should be used instead of
> the original patch (because it conflicts with sata_sis driver as it claims
> the wrong PCI device).

Thanks for pointing this out. Reverting out of both my tree's.

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

