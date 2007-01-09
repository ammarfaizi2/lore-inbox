Return-Path: <linux-kernel-owner+w=401wt.eu-S932503AbXAIXLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbXAIXLb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 18:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbXAIXLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 18:11:31 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60915 "EHLO
	fr.zoreil.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932503AbXAIXLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 18:11:30 -0500
Date: Wed, 10 Jan 2007 00:09:45 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Anders Karlsson <trudheim@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: D-Link DFE-580TX adapter problems
Message-ID: <20070109230945.GA27738@electric-eye.fr.zoreil.com>
References: <1168177183.15748.4.camel@lenin> <20070108201257.GA28440@electric-eye.fr.zoreil.com> <1168297269.27317.7.camel@lenin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7AUc2qLy4jB3hD7Z"
Content-Disposition: inline
In-Reply-To: <1168297269.27317.7.camel@lenin>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7AUc2qLy4jB3hD7Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Anders Karlsson <trudheim@gmail.com> :
[...]
> PCI ID's in there, so this driver *should* work. In the past, it *has*
> worked, but that was on a older kernel (2.6.8 or thereabouts).

No datapoint beyond 2.6.12 ? It would make thinks easier (for you :o} ).

> If there are patches or tweaks to the driver, I am willing and able to
> test them.

Compressed patch attached. Apply with patch -R and see if it behaves
differently. No warranty.

-- 
Ueimor

--7AUc2qLy4jB3hD7Z
Content-Type: application/x-gzip
Content-Disposition: attachment; filename="sundance.patch.gz"
Content-Transfer-Encoding: base64

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
A2/Xn7rvVZrpuXdPtps/4Wb+H680XjkSEAAA

--7AUc2qLy4jB3hD7Z--
