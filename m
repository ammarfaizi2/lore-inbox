Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264286AbUGAIS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUGAIS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 04:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264296AbUGAIS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 04:18:29 -0400
Received: from mail1.village.tin.it ([195.14.96.132]:44041 "EHLO
	village.telecomitalia.it") by vger.kernel.org with ESMTP
	id S264286AbUGAIS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 04:18:28 -0400
Message-ID: <40E3C9AF.4000306@gandalf.sssup.it>
Date: Thu, 01 Jul 2004 10:22:07 +0200
From: michael trimarchi <trimarchi@gandalf.sssup.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Real time 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm working on porting modular real time scheduler on linux layer ... 
I'm using only kernel thread... Actually I dont't call the 
kernel_thread(init, .... and I inizialize my scheduler and OS struct... 
I schedule my kernel thread... I'm trying to use the printk in the 
kernel_thread but sometimes I dont't having result on the console. The 
console does't print my debug on screen... Is there an unburred printk?

Best regards
Michael Trimarchi


