Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUGMDEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUGMDEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 23:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUGMDEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 23:04:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8360 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263040AbUGMDEw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 23:04:52 -0400
Message-ID: <40F35140.6020509@pobox.com>
Date: Mon, 12 Jul 2004 23:04:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA disk device naming ?
References: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0407130415430.15806-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:
> Hi,
> 
> After a rather tiresome nightly sit through, we discovered that when
> going from kernel 2.6.3 to kernel 2.6.7 the SATA disk device naming
> on at least the AMD64 platform changes from : /dev/hde and up 
> to /dev/sda and up. What a total disaster. 


Whoever builds your kernels changed around the kernel configuration on you.

SATA "disk naming" (what driver you use) did not change from 2.6.3 to 2.6.7.

	Jeff


