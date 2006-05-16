Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWEPFHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWEPFHz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWEPFHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:07:55 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:10234 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751292AbWEPFHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:07:55 -0400
Message-ID: <44695E29.20001@am-anger-1.de>
Date: Tue, 16 May 2006 07:07:53 +0200
From: Heiko Gerstung <heiko@am-anger-1.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060509)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Willy Tarreau <willy@w.ods.org>
Subject: Re: Bug related to bonding
References: <44684B60.1070705@am-anger-1.de> <20060516045332.GN11191@w.ods.org> <44695D2A.9080705@am-anger-1.de>
In-Reply-To: <44695D2A.9080705@am-anger-1.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:25672344472c4ac2bbe53bd9833f99fb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heiko Gerstung wrote:
> Thank you very much for the hint. I was able to track this down to the
> driver which seems to crash when trying to serve a ETHTOOL_GSET ioctl
> from the bonding driver. When I comment that out, it does not crash
> anymore but then there is link detection available, of course.
>
>   

"... but then there is _no_ link detection available, of course" was
what I wanted to say...

Early in the morning Typo (tm)


Sorry!

Regards,
Heiko
