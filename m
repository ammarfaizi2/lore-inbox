Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbTEEUsK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 16:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbTEEUsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 16:48:10 -0400
Received: from lakemtao01.cox.net ([68.1.17.244]:11252 "EHLO
	lakemtao01.cox.net") by vger.kernel.org with ESMTP id S261352AbTEEUsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 16:48:09 -0400
Message-ID: <3EB6D0E9.6070604@cox.net>
Date: Mon, 05 May 2003 16:00:25 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: menuconfig error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Menuconfig in 2.4.x allows me to load and save my configuration files to 
/boot. Menuconfig in 2.5.x allows me to load the configuration from 
/boot, but when I try to write to it, it tells me that it can't. I'm 
logged in as root, so I see no reason why 2.4.x can and 2.5.x cannot.

Thanks,
David

