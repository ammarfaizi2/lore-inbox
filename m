Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266981AbUBFXI0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:08:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265807AbUBFXI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:08:26 -0500
Received: from mail-02.iinet.net.au ([203.59.3.34]:61409 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S266983AbUBFXIJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:08:09 -0500
Message-ID: <40241DC9.6070108@cyberone.com.au>
Date: Sat, 07 Feb 2004 10:05:45 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: marcel cotta <mc123@mail.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: VM patches (please review)
References: <40241C96.6010602@mail.ru>
In-Reply-To: <40241C96.6010602@mail.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



marcel cotta wrote:

> hey nick
>
> these patches are working great for me (k7-2400+,256mb ram)
>
> whenever about 100M of swap were in use, the system was
> nearly unusable when i switched to another app under X
>
> with your patches i got interactivity back and it nearly feals like 2.4
>
> thanks :)
>

That's great Marcel, thanks for the feedback.

The patches are in Andrew's -mm tree now so they should
work their way into 2.6 after some more review and testing.

Nick

