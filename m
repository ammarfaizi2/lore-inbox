Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUCODCe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 22:02:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbUCODCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 22:02:34 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13971 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262085AbUCODCd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 22:02:33 -0500
Message-ID: <40551CBB.9070509@pobox.com>
Date: Sun, 14 Mar 2004 22:02:19 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rddunlap@osdl.org>
CC: lkml <linux-kernel@vger.kernel.org>, benh@kernel.crashing.org,
       davem@redhat.com
Subject: Re: [patch/RFC] networking menus
References: <20040314163327.53102f46.rddunlap@osdl.org>
In-Reply-To: <20040314163327.53102f46.rddunlap@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> Does this need to be discussed on netdev (also)?

I dunno if this change necessarily warrants a ton of discussion, but 
please do copy netdev@oss.sgi.com on all networking (net/*) net drivers 
(drivers/net/*) issues.  Some net developers are not subscribed to lkml, 
and it allows for more focused discussion.

	Jeff



