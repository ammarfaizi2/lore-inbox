Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTIWXSJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263467AbTIWXSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 19:18:09 -0400
Received: from pwmail2.portoweb.com.br ([200.248.222.107]:60304 "EHLO
	pwmail2.procempa.com.br") by vger.kernel.org with ESMTP
	id S263466AbTIWXSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 19:18:08 -0400
From: "Bruno Castro da Silva" <sysware@portoweb.com.br>
Reply-to: sysware@portoweb.com.br
To: linux-kernel@vger.kernel.org
Subject: syscall hook
X-Mailer: Quality Web Email v3.0t, http://netwinsite.com/refw.htm
Date: Tue, 23 Sep 2003 20:26:22 -0300
Message-id: <3f70d69e.4d8.16048@portoweb.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I need to put a hook on a syscall so I can monitor the usage
of sockets. I'm trying to do so without having to recompile
the kernel (eg by using modules). Can anyone give me a hint
on how to achieve this?


Thanks in advance,

Bruno
