Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbWH0QaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbWH0QaW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 12:30:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWH0QaW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 12:30:22 -0400
Received: from gw.goop.org ([64.81.55.164]:60364 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932167AbWH0QaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 12:30:21 -0400
Message-ID: <44F1C899.4020505@goop.org>
Date: Sun, 27 Aug 2006 09:30:17 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Miles Lane <miles.lane@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
       netdev@vger.kernel.org
Subject: Re: 2.6.18-rc4-mm[1,2,3] -- Network card not getting assigned an
 "eth" device name
References: <a44ae5cd0608270007gc6a919fx9e36562d8023635d@mail.gmail.com> <20060827001943.c559d37d.akpm@osdl.org>
In-Reply-To: <20060827001943.c559d37d.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Jeremy reported that a while back too.  I do not know what is causing it
> and as far as I know no net developers have yet looked into it.
>   

It went away with -rc4-mm[23] for me...

    J
