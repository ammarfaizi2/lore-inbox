Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWJDUqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWJDUqZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWJDUqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:46:25 -0400
Received: from maxwell.spina.si ([193.77.104.223]:61139 "EHLO maxwell.spina.si")
	by vger.kernel.org with ESMTP id S1751107AbWJDUqY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:46:24 -0400
Message-ID: <45241DF5.5080403@kanardia.eu>
Date: Wed, 04 Oct 2006 22:47:49 +0200
From: Rok Markovic <kernel@kanardia.eu>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Keyboard Stuttering
References: <4523FA41.90805@tuxrocks.com>
In-Reply-To: <4523FA41.90805@tuxrocks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Sorenson wrote:
> I'm experiencing some severe keyboard stuttering on my laptop.  The
> problem is particularly bad in X, and I believe it also occurs at the
> console, though I'm having a difficult time verifying that.  The
> problem  shows up as repeated characters (not regular
> key-repeat-related), and sometimes dropped key presses.
>
> I'm running the 2.6.18 x86_64 kernel on a Core 2 Duo.
>
I have the same problem with keyboard, if i am using smp kernel (P4
3.0-HT). Now i am using uniprocessor kernel 2.6.18 and the problem is
solved. The problem was already in kernel 2.6.16,2.6.17,... more than 5
different versions. Few months ago i was trying to trace the source of
problem but without any success.

Rok


