Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbUJYGRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbUJYGRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 02:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbUJYGRP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 02:17:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56455 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261543AbUJYGRD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 02:17:03 -0400
Message-ID: <417C9A4E.3030909@pobox.com>
Date: Mon, 25 Oct 2004 02:16:46 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
CC: linux-kernel@vger.kernel.org, Netdev <netdev@oss.sgi.com>
Subject: Re: linux-2.6.9 eepro100 warning
References: <200410232313.AA00003@prism.kumin.ne.jp>
In-Reply-To: <200410232313.AA00003@prism.kumin.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seiichi Nakashima wrote:
> Hi.
> 
> I update linux kernel form 2.6.8.1 to 2.6.9.
> I found eepro100 warning, then I update 2.6.10-rc1, but same result.
> It is only warning, I think pro100 may work fine.

This should be fixed in the 2.6.9-mm tree (via my netdev-2.6 tree).

Note that eepro100 driver will be deleted soon.

	Jeff



