Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262432AbTKIMgr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 07:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbTKIMgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 07:36:47 -0500
Received: from mail.gmx.de ([213.165.64.20]:967 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262432AbTKIMgr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 07:36:47 -0500
X-Authenticated: #15936885
Message-ID: <3FAE34E1.7040808@gmx.net>
Date: Sun, 09 Nov 2003 13:36:49 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Markus_H=E4stbacka?= <midian@ihme.org>
CC: Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] forcedeth
References: <3FAC837F.2070601@gmx.net> <1068323168.25759.4.camel@midux>
In-Reply-To: <1068323168.25759.4.camel@midux>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Hästbacka wrote:
> I tested this driver for my Nforce2 mobo on 2.6.0-test9, and this driver
> seemed useless, it just printed some random numbers in my konsole (And
> trust me, it was hard to edit lilo.conf so I even could boot back to old
> kernel when all the numbers just were jumping around) And it broke the
> other card too, ifconfig was right, now there was this card too, but no
> one from them worked. Thanks anyway.

Does it work with nvnet? Could you mail me the logs and the output of
lspci -vvvxxx
as root? Running lspci as user will not give enough info.

Thanks,
Carl-Daniel

