Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265896AbUEUSn5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265896AbUEUSn5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 14:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265970AbUEUSn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 14:43:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55513 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265896AbUEUSn4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 14:43:56 -0400
Message-ID: <40AE4DDC.7050508@pobox.com>
Date: Fri, 21 May 2004 14:43:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Maurice Volaski <mvolaski@aecom.yu.edu>
CC: linux-kernel@vger.kernel.org, aj@andaco.de, davem@nuts.davemloft.net,
       mchan@broadcom.com
Subject: Re: tg3 module in kernel 2.6.5 panics
References: <a06100547bcd3f33b5b73@[129.98.90.227]>
In-Reply-To: <a06100547bcd3f33b5b73@[129.98.90.227]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maurice Volaski wrote:
> The tg3 module in (gentoo) kernel 2.6.5 panics on boot on a dual-opteron 
> 248 box with 4G RAM. I copied the following screen output...


This looks like kobject stuff unrelated to tg3.

Does 2.6.6 fail similarly?

	Jeff


