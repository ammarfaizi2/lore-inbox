Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272864AbTHEQnw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 12:43:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272881AbTHEQnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 12:43:52 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:24704 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S272864AbTHEQma
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 12:42:30 -0400
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give
	us an info about which one was killed
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030805105901.GA329@elf.ucw.cz>
References: <200307312254.16964.m.c.p@wolk-project.de>
	 <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
	 <20030805105901.GA329@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060101516.1188.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 Aug 2003 17:38:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-05 at 11:59, Pavel Machek wrote:
> I agree it is not good enough for 2.4.X, but it looks good to me for
> 2.6. That information can be get by ps, right? If we decide it is not
> okay to print process names to syslog, maybe oom killer should be
> fixed, too?

SAK allows me to see what was running without having an account on the box

