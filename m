Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVCAWdR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVCAWdR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 17:33:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVCAWcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 17:32:50 -0500
Received: from magic.adaptec.com ([216.52.22.17]:54719 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S262110AbVCAWcS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 17:32:18 -0500
Message-ID: <4224ED66.2020200@adaptec.com>
Date: Tue, 01 Mar 2005 17:32:06 -0500
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: dougg@torque.net, Adrian Bunk <bunk@stusta.de>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] SCSI: possible cleanups
References: <20050228213159.GO4021@stusta.de> <4224245E.6090503@torque.net> <42247EF0.9000404@adaptec.com> <20050301221753.GA5742@infradead.org>
In-Reply-To: <20050301221753.GA5742@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Mar 2005 22:32:10.0130 (UTC) FILETIME=[81D52720:01C51EAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/05 17:17, Christoph Hellwig wrote:
> Doing it in the core means less duplication and avoiding updating
> all drivers.

I agree.

	Luben

