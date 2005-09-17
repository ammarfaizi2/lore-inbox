Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbVIQGFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbVIQGFd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 02:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750956AbVIQGFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 02:05:32 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:34953 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750954AbVIQGFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 02:05:32 -0400
Message-ID: <432BB225.8050605@v.loewis.de>
Date: Sat, 17 Sep 2005 08:05:25 +0200
From: =?ISO-8859-1?Q?=22Martin_v=2E_L=F6wis=22?= <martin@v.loewis.de>
User-Agent: Debian Thunderbird 1.0.6 (X11/20050802)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
References: <4NsP0-3YF-11@gated-at.bofh.it> <4NsP0-3YF-13@gated-at.bofh.it> <4NsP0-3YF-15@gated-at.bofh.it> <4NsP0-3YF-17@gated-at.bofh.it> <4NsP1-3YF-19@gated-at.bofh.it> <4NsP1-3YF-21@gated-at.bofh.it> <4NsOZ-3YF-9@gated-at.bofh.it> <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4Nu4p-5Js-3@gated-at.bofh.it> <432B2E09.9010407@v.loewis.de> <432B424A.4020508@zytor.com>
In-Reply-To: <432B424A.4020508@zytor.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Did you miss the point?  There has been a standard for marking for *30
> years*, and virtually NOONE (outside Japan) uses it.

I understood that fact - but I fail to see the point. If you mean to
imply "people did not use ISO-2022, therefore, they will never use
encoding declarations", I think this implication is false. People
do use encoding declarations.

If you mean to imply "people did not use ISO-2022, therefore, they
will never use the UTF-8 signature", I think this implications is
also false. People do use the UTF-8 signature, even outside Japan.
The primary reason is that the UTF-8 signature is much easier to
implement than ISO-2022: if you support UTF-8 in your tool (say,
a text editor), anyway, adding support for the UTF-8 signature
is almost trivial. Therefore, many more editors support the UTF-8
signature today than ever supported ISO-2022.

Regards,
Martin
