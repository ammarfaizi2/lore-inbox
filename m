Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751846AbWJMUJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751846AbWJMUJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 16:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbWJMUJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 16:09:36 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:7337 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751846AbWJMUJg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 16:09:36 -0400
Subject: Re: [PATCH] HP mobile data protection system driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Burman Yan <yan_952@hotmail.com>
Cc: arjan@infradead.org, davej@redhat.com, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, pazke@donpac.ru
In-Reply-To: <BAY20-F8BFE6FB1EB53A9364234ED80A0@phx.gbl>
References: <BAY20-F8BFE6FB1EB53A9364234ED80A0@phx.gbl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 21:34:45 +0100
Message-Id: <1160771685.25218.80.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 20:59 +0200, ysgrifennodd Burman Yan:
> I guess it may be a good idea after all to change the sysfs file it to hdaps 
> for now.

Perhaps it would be better to provide a new they all provide which
indicates 2 v 3 dimensions and also provides a scaled data source so
that you don't get confusion or have to adjust the daemon for each user.

If HDAPS is an IBM^WLeonovo mark thats another reason the final generic
file shouldn't be called HDAPS

