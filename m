Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbVE0HIl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbVE0HIl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVE0HGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:06:06 -0400
Received: from mail.avantwave.com ([210.17.210.210]:16519 "EHLO
	mail.avantwave.com") by vger.kernel.org with ESMTP id S261917AbVE0HBX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:01:23 -0400
Message-ID: <4296C5C0.4030409@avantwave.com>
Date: Fri, 27 May 2005 15:01:20 +0800
From: Tomko <tomko@avantwave.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: question about /dev/console and /dev/tty
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Which device is /dev/console pointing to ? or is it a virtual device ? 
Actually why this node is made?

Why kernel default not providing a control terminal on /dev/console but 
on other device ?

It is not surprising that we can use CTRL-C to terminate some process on 
i386 linux on the Desktop machine,  is that mean the shell on our 
desktop is not using /dev/console ? so where are the shell running on?

Hope anyone can do me a favour.

Regards,
TOM



