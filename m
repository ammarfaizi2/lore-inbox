Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbUB1RHE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Feb 2004 12:07:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261888AbUB1RHE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Feb 2004 12:07:04 -0500
Received: from smtp.terra.es ([213.4.129.129]:39077 "EHLO tsmtp2.mail.isp")
	by vger.kernel.org with ESMTP id S261883AbUB1RHC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Feb 2004 12:07:02 -0500
Date: Sat, 28 Feb 2004 18:05:24 +0100
From: Diego Calleja <grundig@teleline.es>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc1 oops on HPFS filesystem file rename
Message-Id: <20040228180524.6e879839.grundig@teleline.es>
In-Reply-To: <20040228114225.GC16357@parcelfarce.linux.theplanet.co.uk>
References: <20040228110403.GC557@maurice.stee.nl>
	<20040228114225.GC16357@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Sat, 28 Feb 2004 11:42:25 +0000 viro@parcelfarce.linux.theplanet.co.uk escribió:

> Fix follows.  That, BTW, means that *nobody* had ever tried to use hpfs
> r/w since 2.5.3-pre3.

Not true, it seems that at least one person tried it:
http://bugme.osdl.org/show_bug.cgi?id=1964


Diego Calleja
