Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbULJRxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbULJRxe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbULJRwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:52:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16856 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261777AbULJRvl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:51:41 -0500
Message-ID: <41B9E224.9030705@pobox.com>
Date: Fri, 10 Dec 2004 12:51:32 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Julien Langer <jlanger@zigweb.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Sil3112 and Seagate ST3160023AS
References: <1102691231.3921.13.camel@moeff>
In-Reply-To: <1102691231.3921.13.camel@moeff>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Julien Langer wrote:
> Is there a way to disable this fix, which slows down my drive, since it
> worked fine for a long time without this fix on older kernel versions?
> I'm using the deprecated ide driver for the sil controller, not libata.


Unfortunately it's just a matter of time until you hit a problem, 
without the errata fix that causes the performance loss.

	Jeff


