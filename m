Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268699AbUI3FAm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268699AbUI3FAm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 01:00:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUI3FAm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 01:00:42 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:42406 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S268699AbUI3FAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 01:00:40 -0400
Date: Wed, 29 Sep 2004 21:59:34 -0700
From: Tom Duffy <Tom.Duffy@Sun.COM>
Subject: Re: Linux 2.6.9-rc3
In-reply-to: <pan.2004.09.30.04.53.05.120184@trippelsdorf.net>
To: "Markus T." <markus@trippelsdorf.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <415B92B6.5020804@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <Pine.LNX.4.58.0409292036010.2976@ppc970.osdl.org>
 <pan.2004.09.30.04.53.05.120184@trippelsdorf.net>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus T. wrote:
> # bzcat patch-2.6.9-rc3.bz2 | patch -p1
> ...
> patching file fs/nfs/file.c
> Hunk #2 FAILED at 74.
> Hunk #3 FAILED at 91.
> 2 out of 11 hunks FAILED -- saving rejects to file fs/nfs/file.c.rej
> ...

apply against 2.6.8, not 2.6.8.1

-tduffy
