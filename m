Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263865AbUECSwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbUECSwB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:52:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263879AbUECSwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:52:00 -0400
Received: from [80.246.69.6] ([80.246.69.6]:35531 "HELO mail.flightmedia.ru")
	by vger.kernel.org with SMTP id S263865AbUECSvi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:51:38 -0400
Message-ID: <63174.195.161.105.106.1083610296.squirrel@mail.flightmedia.ru>
Date: Mon, 3 May 2004 22:51:36 +0400 (MSD)
Subject: tty question
From: "Dvorkin" <dvorkin@flightmedia.ru>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=koi8-r
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to write LKM that acts like TTY.
i'm using tty_register_driver(...) to register my virtual device and it's
functions... there are open/close/write/ioctl functions, but what function
acts as READ in struct tty_driver ?

I'm sorry for the stupid question...

-- 
WBR, Dvorkin

