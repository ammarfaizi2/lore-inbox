Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265779AbTL3NLs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 08:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265788AbTL3NLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 08:11:48 -0500
Received: from rat-3.inet.it ([213.92.5.93]:45805 "EHLO rat-3.inet.it")
	by vger.kernel.org with ESMTP id S265779AbTL3NLr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 08:11:47 -0500
Message-ID: <3FF187B3.1030003@katamail.com>
Date: Tue, 30 Dec 2003 14:12:03 +0000
From: sogentoo <sogentoo@katamail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031215 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0 and PS/2 wheel mouse
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If i run /sbin/modprobe psmouse
it tells to me
FATAL: Modules psmouse already in kernel
and mouse doesn't work
dmesg I think it's ok
kernel modules are loaded
psmouse
radeon
