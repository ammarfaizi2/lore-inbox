Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263891AbTKLRLv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 12:11:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263895AbTKLRLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 12:11:50 -0500
Received: from mail.xor.ch ([212.55.210.163]:28934 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S263891AbTKLRLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 12:11:50 -0500
Message-ID: <3FB2691C.DB309FEC@orpatec.ch>
Date: Wed, 12 Nov 2003 18:08:44 +0100
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: Eric Sandall <eric@sandall.us>
CC: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: USB-keyboard not recognized when not connected during startup
References: <3FAFDA82.864DC1BE@orpatec.ch> <1068602198.3fb193567bcc7@horde.sandall.us>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Sandall wrote:
> 
> Quoting Otto Wyss <otto.wyss@orpatec.ch>:
> > Please CC, I'm not subscribed.
> >
> 
> Have you tried installing hotplug? That should automatically load the
> modules/devices needed when you plug it in after boot.
> 
Of course I use hotplue and so probably does Knoppix. I'll try Morphix
but I'm quiet sure it also shows this problem. This is a worse USB bug
in kernel 2.4.21 and I'm not sure if it's fixed in one of the later ones.

O. Wyss

-- 
See "http://wxguide.sourceforge.net/" for ideas how to design your app
