Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267473AbUHPGwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267473AbUHPGwZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 02:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267474AbUHPGwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 02:52:25 -0400
Received: from mx1.redhat.com ([66.187.233.31]:976 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267469AbUHPGwR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 02:52:17 -0400
Date: Sun, 15 Aug 2004 23:52:04 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: "O.Sezer" <sezeroz@ttnet.net.tr>, linux-kernel@vger.kernel.org,
       zaitcev@redhat.com, <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH 2.4] blacklist a device in usb-storage
Message-Id: <20040815235204.0e9ec874@lembas.zaitcev.lan>
In-Reply-To: <mailman.1092508141.32379.linux-kernel2news@redhat.com>
References: <mailman.1092508141.32379.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Aug 2004 21:22:20 +0300
"O.Sezer" <sezeroz@ttnet.net.tr> wrote:

> The disk in question is VID/PID=0b86:5110 32mb JMTek/eXputer disk.
> http://www.qbik.ch/usb/devices/showdev.php?id=1092 says it can
> never be supported through usb-storage because it claims to be
> usb storage compliant but is not.
>[...]
> If there's any other way of preventing usb-storage to take-
> over this disk, then tell me and despise my ignorance,
> Otherwise, Marcelo please apply ;)

I do not understand what the objective might be. Just do not
use that thing with Linux kernel 2.4. Why do you wish "to revent
usb-storage from taking over this disk"?

-- Pete
