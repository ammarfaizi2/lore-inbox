Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVCVUkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVCVUkv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVCVUjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:39:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36817 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261942AbVCVUhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:37:35 -0500
Message-ID: <42408200.2090402@pobox.com>
Date: Tue, 22 Mar 2005 15:37:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com, cramerj@intel.com,
       john.ronciak@intel.com, ganesh.venkatesan@intel.com
Subject: Re: [patch 2.6.11] e1000: avoid sleeping in watchdog timer context
References: <20050314212510.GA12573@tuxdriver.com>
In-Reply-To: <20050314212510.GA12573@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied this an the flush-workqueue patch

