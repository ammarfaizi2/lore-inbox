Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263116AbRE1SXw>; Mon, 28 May 2001 14:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbRE1SXm>; Mon, 28 May 2001 14:23:42 -0400
Received: from sncgw.nai.com ([161.69.248.229]:8422 "HELO mcafee-labs.nai.com")
	by vger.kernel.org with SMTP id <S263116AbRE1SXb>;
	Mon, 28 May 2001 14:23:31 -0400
Message-ID: <XFMail.20010528112631.davidel@xmailserver.org>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <NEBBIIKAMMOCGCPMPBJOMEJLCDAA.anilk@subexgroup.com>
Date: Mon, 28 May 2001 11:26:31 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Anil Kumar <anilk@subexgroup.com>
Subject: RE: File read.
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 28-Jun-2001 Anil Kumar wrote:
> hi,
> How do i read file within the kernel modules. I hope we can't use the FS
> open... calls within kernel.

You can access fs methods directly.
Look at this newbie article :

http://www.linux-mag.com/2000-11/gear_01.html




- Davide

