Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264522AbTLGUJW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 15:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTLGUJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 15:09:22 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:52162 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264522AbTLGUJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 15:09:21 -0500
Date: Sun, 07 Dec 2003 15:09:20 -0500
From: sean darcy <seandarcy@hotmail.com>
Subject: Re: 260t11-bk4 problem -- hung processes
In-reply-to: <200312062254.RAA26015@clem.clem-digital.net.lucky.linux.kernel>
To: linux-kernel@vger.kernel.org
Message-id: <3FD388F0.3070205@hotmail.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031127
References: <200312062254.RAA26015@clem.clem-digital.net.lucky.linux.kernel>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Clements wrote:
> With 2.6.0-t11-bk4, mozilla hangs before it can come up.
> At this point other processes that touch the associated
> /proc entries hang also (such as a ps). Can not kill the
> process. Shutdown also hangs.
> 
> Everything fine with bk3.
> 

Same here.

I can run top. But as soon as I try to start mozilla, top freezes. Other 
odd processes hang: the shutdown script for cups hangs; uic from qt 
hangs; startkde hangs ( good thing gnome works! ).

bk3 also works for me. From the bk4 changelog, not clear whats the problem

sean

