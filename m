Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262877AbTHUUbc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTHUUbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 16:31:31 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:16134 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262877AbTHUUba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 16:31:30 -0400
Date: Thu, 21 Aug 2003 22:31:41 +0200
From: Diego Calleja =?ISO-8859-15?Q?Garc=EDa?= <aradorlinux@yahoo.es>
To: Lou Langholtz <ldl@aros.net>
Cc: jgarzik@pobox.com, willy@debian.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: [PATCH] bio.c: reduce verbosity at boot
Message-Id: <20030821223141.74ccb89e.aradorlinux@yahoo.es>
In-Reply-To: <3F44F88F.9010106@aros.net>
References: <20030821150211.GU19630@parcelfarce.linux.theplanet.co.uk>
	<3F44E2EB.6020508@pobox.com>
	<3F44F88F.9010106@aros.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Thu, 21 Aug 2003 10:51:27 -0600 Lou Langholtz <ldl@aros.net> escribió:

> How about using KERN_DEBUG and augmenting the dmesg store so that the 
> level that is saved is configurable? Even compile time configurable 
> seems reasonable to start. But axeing out even the possibility of boot 
> time info seems bad to me.

Like this?

(14) Kernel log buffer size (16 => 64KB, 17 => 128KB)  

Available at least in 2.6.0-test3 under "General setup"

