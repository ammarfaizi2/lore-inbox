Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265029AbUGCGJG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265029AbUGCGJG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jul 2004 02:09:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265037AbUGCGJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jul 2004 02:09:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31703 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265029AbUGCGJE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jul 2004 02:09:04 -0400
Message-ID: <40E64D71.5020802@pobox.com>
Date: Sat, 03 Jul 2004 02:08:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jt@hpl.hp.com
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Dan Williams <dcbw@redhat.com>, Pavel Roskin <proski@gnu.org>,
       David Gibson <hermes@gibson.dropbear.id.au>
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
References: <20040702222655.GA10333@bougret.hpl.hp.com>
In-Reply-To: <20040702222655.GA10333@bougret.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Tourrilhes wrote:
> 	Jeff, does BitKeeper allow to merge patches at an earlier
> point than the last version and reconciliate both branches ? That
> might come handy.


Yes, this is one of BitKeeper's strengths.

I can create a BitKeeper repository circa 2.6.0, merge a patch, and then 
merge that repository into the 2.6.7-BK-latest repository.

	Jeff


