Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261897AbUFNE17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261897AbUFNE17 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 00:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFNE17
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 00:27:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27541 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261897AbUFNE14
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 00:27:56 -0400
Message-ID: <40CD293D.4040808@pobox.com>
Date: Mon, 14 Jun 2004 00:27:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [1/12] don't dereference netdev->name before register_netdev()
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com>
In-Reply-To: <20040614003331.GP1444@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu has an updated patch for this, I'll compare both more closely...
