Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268104AbUHKQ05@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268104AbUHKQ05 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268103AbUHKQ05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 12:26:57 -0400
Received: from the-village.bc.nu ([81.2.110.252]:57041 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268104AbUHKQ0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 12:26:52 -0400
Subject: Re: Fork and Exec a process within the kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: root@chaos.analogic.com
Cc: Erik Mouw <erik@harddisk-recovery.com>, Paul Jackson <pj@sgi.com>,
       Eric Masson <cool_kid@future-ericsoft.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0408110743020.15953@chaos>
References: <4117E68A.4090701@future-ericsoft.com>
	 <20040809161003.554a5de1.pj@sgi.com> <4118E822.3000303@future-ericsoft.com>
	 <20040810092116.7dfe118c.pj@sgi.com>
	 <Pine.LNX.4.53.0408101456260.13579@chaos>
	 <20040811095139.GA10047@harddisk-recovery.com>
	 <Pine.LNX.4.53.0408110721540.15879@chaos>
	 <20040811114100.GB10047@harddisk-recovery.nl>
	 <Pine.LNX.4.53.0408110743020.15953@chaos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092237847.18968.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 11 Aug 2004 16:24:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-08-11 at 12:55, Richard B. Johnson wrote:
> RedHat is NOT Linux. The MAJOR-MINOR 5.1 used in RedHat for the
> console has a very serious problem for anybody doing development

Actually you might want to

a) man sysklogd
b) check devices.txt distributed with the kernel.

The former will explain why you are wrong and how to channel log
messages, the latter will explain how you are further wrong.

