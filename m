Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbUE1NFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUE1NFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 09:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262897AbUE1NFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 09:05:12 -0400
Received: from tristate.vision.ee ([194.204.30.144]:9140 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S262874AbUE1NFG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 09:05:06 -0400
Message-ID: <40B73900.6070609@vision.ee>
Date: Fri, 28 May 2004 16:05:04 +0300
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040509)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: filesystem corruption (ReiserFS, 2.6.6): regions replaced by
 \000 bytes
References: <20040528122854.GA23491@clipper.ens.fr> <1085748363.22636.3102.camel@watt.suse.com>
In-Reply-To: <1085748363.22636.3102.camel@watt.suse.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Uh, seems I've experienced this problem too. But since there were
disk-full condition and at the same time electricity went away ... I thought
I had really bad luck (needed to apt-get --reinstall whole debian).

Glad to hear it's found and fixed now.

Lenar

Chris Mason wrote:

>The good news is that we tracked this one down recently.  2.6.7-rc1
>shouldn't do this anymore.
>
>-chris
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>  
>

