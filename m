Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263660AbTLKFPz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 00:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTLKFPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 00:15:55 -0500
Received: from mail-05.iinet.net.au ([203.59.3.37]:5773 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S263660AbTLKFPx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 00:15:53 -0500
Message-ID: <3FD7FCF5.7030109@cyberone.com.au>
Date: Thu, 11 Dec 2003 16:13:25 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Donald Maner <donjr@maner.org>
CC: Raul Miller <moth@magenta.com>, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
References: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
In-Reply-To: <C033B4C3E96AF74A89582654DEC664DB0672F1@aruba.maner.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Donald Maner wrote:

>The kernel you're using WAS compiled with CONFIG_HIGHMEM4G=y, correct?
>
>-----Original Message-----
>From: Raul Miller [mailto:moth@magenta.com] 
>Sent: Wednesday, December 10, 2003 10:52 PM
>To: linux-kernel@vger.kernel.org
>Subject: PROBLEM: Linux 2.6.0-test11 only lets me use 1GB out of 2GB
>ram.
>
>
>[1.] Linux 2.6.0-test11 only lets me use 1GB out of 2GB ram.
>

Raul Miller wrote:

>
>[7.2.] /proc/cpuinfo says:
>
>processor       : 0
>vendor_id       : AuthenticAMD
>cpu family      : 15
>model           : 5
>model name      : AMD Opteron(tm) Processor 240
>

Or ARCH=x86_64 ?


