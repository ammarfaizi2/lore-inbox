Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265066AbUEKXdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265066AbUEKXdl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 19:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265054AbUEKXdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 19:33:40 -0400
Received: from brmea-mail-4.Sun.COM ([192.18.98.36]:42632 "EHLO
	brmea-mail-4.sun.com") by vger.kernel.org with ESMTP
	id S265066AbUEKXdP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 19:33:15 -0400
Date: Tue, 11 May 2004 18:33:14 -0500
From: Fernando Paredes <Fernando.Paredes@Sun.COM>
Subject: Toshiba keyboard lockups
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <40A162BA.90407@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5)
 Gecko/20031007
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a previous thread on this, last month.

I updated to 2.6.6 and I still get these random lockups. Nothing in 
dmesg or /var/log/messages. Too annoying as I have to reboot the machine 
constantly. Does anyone know the status on this? Is t a toshiba hardware 
bug (is that possible?) or a bug in serio.c or keybd.c?

Thanks!

