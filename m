Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262053AbUJZBj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262053AbUJZBj7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262069AbUJZBjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:39:51 -0400
Received: from zeus.kernel.org ([204.152.189.113]:471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262053AbUJZBXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:40 -0400
Message-ID: <417DA216.5030404@spymac.com>
Date: Tue, 26 Oct 2004 03:02:14 +0200
From: Gunther Persoons <gunther_persoons@spymac.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040916)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFS with wireless network card takes 70~100% CPU
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

When try to send or receive a file from my NFS server with my wireless 
pcmcia network card(cisco), cpu usage
goes to 100% and stays there. Doing this on the same comp with a wired 
network card cpu usage stays at 8~10%.
I have this problem with kernel 2.6.9-ck2, 2.6.9-rc4-RT. I dont have 
this problem with kernel 2.6.9-rc1(cpu usage stays around 10%~20%). 
Those are the only ones i tested.
