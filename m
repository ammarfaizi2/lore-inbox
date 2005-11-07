Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVKGQdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVKGQdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964860AbVKGQdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:33:23 -0500
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:53875 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S964835AbVKGQdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:33:22 -0500
Message-ID: <436F81D1.7000100@gentoo.org>
Date: Mon, 07 Nov 2005 16:33:21 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051104)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ubuntu kernel tree
References: <20051106013752.GA13368@swissdisk.com>	 <436E17CA.3060803@gentoo.org> <1131316729.1212.58.camel@localhost.localdomain>
In-Reply-To: <1131316729.1212.58.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> The FC kernel trees rpms and source rpms are distributed from the fedora
> site. 'Production' kernels go to the updates directory, others which are
> intended for testing go to the update testing directory and may or may
> not work wonderfully.

Source RPM's will just contain a Linux kernel tree with your patches already 
applied, right?

Is there an easier way to see what redhat/fedora have patched in, short of 
finding the closest vanilla tree and using "diff"?

Daniel
