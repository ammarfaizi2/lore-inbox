Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271311AbTGQCly (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 22:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271316AbTGQCly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 22:41:54 -0400
Received: from mail-01.iinet.net.au ([203.59.3.33]:45073 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S271311AbTGQClx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 22:41:53 -0400
Message-ID: <3F160C60.9050301@ii.net>
Date: Thu, 17 Jul 2003 10:39:28 +0800
From: Wade <neroz@ii.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5a) Gecko/20030618 Thunderbird/0.1a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <kernel@kolivas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6.1int
References: <200307171213.02643.kernel@kolivas.org>
In-Reply-To: <200307171213.02643.kernel@kolivas.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas wrote:
> The bug in the O6int patch probably wasn't responsible for WIktor's problem 
> actually. It shouldn't manifest for a very long time. Anyway here is the fix 
> and a couple of minor cleanups.

Thanks Con! Running the modified 06.1 patch now. With the previous patch
I did notice a slowdown of X in general over time (slow repainting and 
such).


Lets see how this one goes...


