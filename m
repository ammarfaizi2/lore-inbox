Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270667AbTHAMjA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270752AbTHAMjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:39:00 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:18 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S270667AbTHAMi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:38:59 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give us an info about which one was killed
Date: Fri, 1 Aug 2003 14:38:06 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, vda@port.imtp.ilyichevsk.odessa.ua
References: <200307312254.16964.m.c.p@wolk-project.de> <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk> <200308011425.29058.m.c.p@wolk-project.de>
In-Reply-To: <200308011425.29058.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308011438.06857.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 14:26, Marc-Christian Petersen wrote:

Hi Alan,

> well, it get logged to syslog(3) and dmesg(8). No normal user has access to
> it, no?
forget it. Mainline kernels give the normal user access to dmesg :)

ciao, Marc

