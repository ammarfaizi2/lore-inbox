Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262117AbUKROxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262117AbUKROxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 09:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbUKROwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 09:52:45 -0500
Received: from mail.aknet.ru ([217.67.122.194]:57095 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S262117AbUKROwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 09:52:40 -0500
Message-ID: <419CB75C.3080605@aknet.ru>
Date: Thu, 18 Nov 2004 17:53:16 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc1-mm5
References: <41967669.3070707@aknet.ru> <Pine.LNX.4.58L.0411150112520.22313@blysk.ds.pg.gda.pl> <4198EFE5.5010003@aknet.ru> <Pine.LNX.4.58L.0411151821050.3265@blysk.ds.pg.gda.pl> <419A38EE.8000202@aknet.ru> <Pine.LNX.4.58L.0411162226500.8068@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.58L.0411162226500.8068@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Maciej W. Rozycki wrote:
>> thats for sure. I think there was some
>> fallback, which is now either broken or
> Indeed there was and it still is there, namely the following code:
OK.
Another thing I am wondering about,
is why the lapic produces the NMI on
my Athlon so slowly. It is something
like 1 NMI in 20 seconds or so. And
it looks like the frequency changes
from one boot to another.
It didn't work properly with any kernel,
so maybe the lapic itself is buggy,
but maybe this is a kernel's bug that
can be debugged out somehow? Or is
there anywhere something that allows
me to specify the frequency? The rate
I currently have, is really pretty
much useless for anything.

