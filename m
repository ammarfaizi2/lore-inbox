Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSGAPRD>; Mon, 1 Jul 2002 11:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSGAPRC>; Mon, 1 Jul 2002 11:17:02 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:27318 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S315485AbSGAPRB>; Mon, 1 Jul 2002 11:17:01 -0400
Date: Mon, 1 Jul 2002 11:18:58 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200207011518.g61FIwO21599@devserv.devel.redhat.com>
To: Ralph Corderoy <ralph@inputplus.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Happy Hacking Keyboard Lite Mk 2 USB Problems with 2.4.18.
In-Reply-To: <mailman.1025526604.30310.linux-kernel2news@redhat.com>
References: <mailman.1025526604.30310.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>[...]
> I'll try and use hid.o instead, usbkbd.o was just picked by this Red Hat
> 7.2 system on adding the keyboard.

Do up2date and be happy: usbkbd.o was removed from Red Hat kernels
somewhere in erratas.

-- Pete
