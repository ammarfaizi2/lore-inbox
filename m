Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVGYKnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVGYKnR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 06:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbVGYKnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 06:43:16 -0400
Received: from vhost12.digitarus.com ([84.234.16.61]:21143 "EHLO
	vhost12.digitarus.com") by vger.kernel.org with ESMTP
	id S261185AbVGYKnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 06:43:09 -0400
X-ClientAddr: 212.126.40.83
Message-ID: <42E4C25B.6070709@wiggly.org>
Date: Mon, 25 Jul 2005 11:43:39 +0100
From: Nigel Rantor <wiggly@wiggly.org>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.12 Boot Hang Disabled IRQ 11
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Digitarus-vhost12-MailScanner-Information: Please contact Digitarus for more information
X-Digitarus-vhost12-MailScanner: Not scanned: please contact your Internet E-Mail Service Provider for details
X-MailScanner-From: wiggly@wiggly.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

I downloaded and compiled 2.6.12 yesterday, I am currently running 
2.6.7-rc3.

The boot eventually hangs (irq 11, nobody cared) but since the disks 
aren't mounted yet I have no dmesg output.

So, before I can provide a decent report I need some way of getting this 
output, is there a better way than simply copying it down from the terminal?

Ta,

   n

