Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTL2SFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264127AbTL2SFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:05:21 -0500
Received: from 12-229-138-12.client.attbi.com ([12.229.138.12]:22150 "EHLO
	waltsathlon.localhost.net") by vger.kernel.org with ESMTP
	id S264113AbTL2SFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:05:12 -0500
Message-ID: <3FF06CD7.7080201@comcast.net>
Date: Mon, 29 Dec 2003 10:05:11 -0800
From: Walt H <waltabbyh@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031121
X-Accept-Language: en-us
MIME-Version: 1.0
To: Ed Sweetman <ed.sweetman@wmich.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can't eject a previously mounted CD?
References: <3FEF89D5.4090103@comcast.net> <3FEF8BB1.6090704@wmich.edu> <3FEFA36A.5050307@comcast.net> <3FEFDE4A.1030208@wmich.edu> <3FF0580C.5070604@comcast.net> <3FF06A26.8060609@wmich.edu>
In-Reply-To: <3FF06A26.8060609@wmich.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ed Sweetman wrote:
> check out test11-mm1's cdrom.c.  I think it'll make things clear.  I
> just replaced the cdrom.c and ide-cd.h and ide-cd.c files in 2.6.0-mm1
> with 2.6.0-test11-mm1's and things are working perfect.
> 
> 
> 
> 

I was just about to that stage as well :)  Just noticed that -mm2 is out, and it
has specific fixes unlocking tray as well.

-Walt



