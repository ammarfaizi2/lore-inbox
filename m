Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbUKVVFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbUKVVFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 16:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262430AbUKVVEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 16:04:14 -0500
Received: from web.dragon.cz ([213.168.176.4]:24481 "EHLO web.dragon.cz")
	by vger.kernel.org with ESMTP id S262384AbUKVU47 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:56:59 -0500
Message-ID: <41A25296.104@inv.cz>
Date: Mon, 22 Nov 2004 21:56:54 +0100
From: Martin Volf <mv@inv.cz>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041119)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=FCrgen_Otte?= <reviede@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: libata - support for PATA devices on promise TX2 controllers
References: <41a1ed19.6b8b4567.0883.0000@smtp.gmail.com>
In-Reply-To: <41a1ed19.6b8b4567.0883.0000@smtp.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jürgen Otte wrote:
> See topic, is there anyone working on this already?

Yes, I think so:

http://linux.yyz.us/sata/sata-status.html
http://linux.yyz.us/sata/software-status.html
http://www.kernel.org/pub/linux/kernel/people/jgarzik/libata

I'm currently using old/2.6.9-libata1-dev1.patch.bz2 with 2.6.9 and the PATA
port on PDC20378 is working (but I don't know whether TX2 is the same thing).

-- 
Martin


