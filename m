Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264478AbTCXWyN>; Mon, 24 Mar 2003 17:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264482AbTCXWyN>; Mon, 24 Mar 2003 17:54:13 -0500
Received: from air-2.osdl.org ([65.172.181.6]:35043 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264478AbTCXWyM>;
	Mon, 24 Mar 2003 17:54:12 -0500
Message-ID: <33453.4.64.238.61.1048547120.squirrel@www.osdl.org>
Date: Mon, 24 Mar 2003 15:05:20 -0800 (PST)
Subject: Re: CONFIG_VT_CONSOLE in 2.5.6x ?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <louisg00@bellsouth.net>
In-Reply-To: <1048546447.3058.3.camel@tiger>
References: <1048546447.3058.3.camel@tiger>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I can't find CONFIG_VT_CONSOLE anywhere in menuconfig. I am having problems
> not viewing the bootup messages on my monitor. I do have
> console=tty0 in grub.conf.

It's the second line of the Character Devices menu:

  &#9474; &#9474;[*] Virtual terminal
  &#9474; &#9474;[*]   Support for console on virtual terminal     <<<<<

~Randy



