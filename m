Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbTCLRZ5>; Wed, 12 Mar 2003 12:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261811AbTCLRZg>; Wed, 12 Mar 2003 12:25:36 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:15997 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S261807AbTCLRY2>; Wed, 12 Mar 2003 12:24:28 -0500
Message-ID: <3E6EF167.50409@myrealbox.com>
Date: Wed, 12 Mar 2003 08:35:51 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21pre5-ac3
References: <fa.mpr04fi.1a4um8g@ifi.uio.no>
In-Reply-To: <fa.mpr04fi.1a4um8g@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Linux 2.4.21pre5-ac3

Hi Alan,

No surprise, probably, but I'm still getting the kernel oops when
I use swapoff on any partition which is not already mounted as a
swap partition (i.e. what 'swapoff -a' attempts to do.)

I've already tried using very conservative CFLAGS for compiling
both the kernel and util-linux with no improvement.

Any further information I can supply to help fix this?  Any
other tricks I can try?




