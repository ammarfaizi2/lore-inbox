Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263488AbTDCTgT 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 14:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S263508AbTDCTgT 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 14:36:19 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25048 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263488AbTDCTfh 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 14:35:37 -0500
Message-ID: <3E8C8FCE.2050408@pobox.com>
Date: Thu, 03 Apr 2003 14:47:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Nicholas Henke <henken@seas.upenn.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: eepro100 oops on 2.4.20
References: <20030403142457.14227434.henken@seas.upenn.edu>
In-Reply-To: <20030403142457.14227434.henken@seas.upenn.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicholas Henke wrote:
> Below is the patch that fixes an oops on 2.4.20 when insmod'ing eepro100.
>  Looks like a trivial 'oops forgot to replace those' case.


Thanks for the patch.  Looks like it's already fixed in 2.4.21-pre.

	Jeff



