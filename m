Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWGaXVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWGaXVK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 19:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWGaXVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 19:21:10 -0400
Received: from terminus.zytor.com ([192.83.249.54]:60312 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751448AbWGaXVI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 19:21:08 -0400
Message-ID: <44CE9051.5080803@zytor.com>
Date: Mon, 31 Jul 2006 16:20:49 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Al Boldi <a1426z@gawab.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       stable@kernel.org, akpm@osdl.org, chrisw@sous-sol.org, grim@undead.cc
Subject: Re: [stable] [PATCH] initramfs: Allow rootfs to use tmpfs instead
 of ramfs
References: <200607301808.14299.a1426z@gawab.com> <200607310003.56832.a1426z@gawab.com> <44CE5940.5090700@zytor.com> <200607312358.29027.a1426z@gawab.com>
In-Reply-To: <200607312358.29027.a1426z@gawab.com>
Content-Type: text/plain; charset=windows-1256; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
>>>
>>> Being semantically the same, while not exhibiting ramfs pitfalls, makes
>>> it suitable to be pushed into the -stable tree, IMHO.
>> This is total nonsense.
> 
> Are you sure?
> 

Yes.

>> They're very different from an implementation standpoint.
> 
> Think ext2/3.

Not applicable to this case.

	-hpa
