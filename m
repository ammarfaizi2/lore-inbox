Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTENVYy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbTENVYy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 17:24:54 -0400
Received: from corky.net ([212.150.53.130]:29575 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262861AbTENVYx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 17:24:53 -0400
Date: Thu, 15 May 2003 00:37:35 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Mike Touloumtzis <miket@bluemug.com>, Ahmed Masud <masud@googgun.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <Pine.LNX.4.53.0305141724220.12328@chaos>
Message-ID: <Pine.LNX.4.44.0305150035230.12748-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Not so, with the latest Red Hat distribution (9). You can no longer
> set init=/bin/bash at the boot prompt.... well you can set it, but
> then you get an error about killing init. This caused a neighbor
> a lot of trouble when she accidentally put a blank line in the
> top of /etc/passwd. Nobody could log-in. I promised to show her
> how to "break in", but I wasn't able to. I had to take her hard-disk
> to my house, mount it, and fix the password file. All these "attempts"
> at so-called security do is make customers pissed.
>

1. Insert Live-System CD (Knoppix for example)
2. Boot from it.
3. Mount rootfs.
4. Fix things.
5. Remove CD and reboot.

