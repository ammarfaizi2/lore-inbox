Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbTINNx4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 09:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbTINNx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 09:53:56 -0400
Received: from mail-07.iinet.net.au ([203.59.3.39]:21990 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261161AbTINNxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 09:53:55 -0400
Message-ID: <3F6472F4.8080509@ii.net>
Date: Sun, 14 Sep 2003 21:53:56 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.6 patch] add a config option for -Os compilation
References: <20030914121655.GS27368@fs.tum.de>
In-Reply-To: <20030914121655.GS27368@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> The patch below adds a config option OPTIMIZE_FOR_SIZE for telling gcc 
> to use -Os instead of -O2. Besides this, it removes constructs on 
> architectures that had a -Os hardcoded in their Makefiles.

Someone told me that -Os is actually faster than -O2 for Athlons, is 
that true?



