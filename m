Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbTIYBH7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 21:07:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTIYBH7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 21:07:59 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:17889 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261631AbTIYBH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 21:07:58 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Wed, 24 Sep 2003 22:07:55 -0300 (E. South America Standard Time)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 keyboard & mice mandatory again ?
Message-ID: <Pine.WNT.4.58.0309242202410.3564@pervalidus>
X-X-Sender: fredlwm@imap.fastmail.fm
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Mailhot wrote:

> Please revert this change.

Agreed.

But it was much worse when someone removed CONFIG_NETLINK in
some 2.4 release (mainly ?) because Red Hat had a dependency
for it in some init script and people were complaining.

-- 
How to contact me - http://www.pervalidus.net/contact.html
