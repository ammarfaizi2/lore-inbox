Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270752AbTGVLGw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 07:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270768AbTGVLGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 07:06:52 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:24309 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270752AbTGVLGv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 07:06:51 -0400
Subject: Re: Interrupt lost { .... }
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andre Hedrick <andre@linux-ide.org>
Cc: dacin <dacin@hotpop.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10307211913580.29430-100000@master.linux-ide.org>
References: <Pine.LNX.4.10.10307211913580.29430-100000@master.linux-ide.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058872546.2751.9.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Jul 2003 12:15:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-22 at 03:14, Andre Hedrick wrote:
> I am looking into this issue as my customer base who pays for fixes has
> raised the issue.

Turn off local APIC support, local APIC without SMP is broken in the
base tree still

