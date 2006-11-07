Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965556AbWKGREl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965556AbWKGREl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965562AbWKGREl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:04:41 -0500
Received: from mail-out1.fuse.net ([216.68.8.174]:55514 "EHLO smtp1.fuse.net")
	by vger.kernel.org with ESMTP id S965556AbWKGREk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:04:40 -0500
Message-ID: <4550BC94.8000806@fuse.net>
Date: Tue, 07 Nov 2006 12:04:20 -0500
From: "rob.rice" <rob.rice@fuse.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050905
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: aty frame buffer driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a ATI Rage Pro 3D video card
and would like to use the aty frame buffer driver in hi res mode
BUT the best I can get from this driver is 640x480 256 colors
regard less what I set with append in my /etc/lilo.conf (and yes I did 
rerun lilo)
all I have been able to do with fbset is to blank the screen
so where can I find info on using this driver
or
how do I set the video mode for this driver in my lilo.conf
or could this be a bug
