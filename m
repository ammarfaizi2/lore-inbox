Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263191AbTDVO53 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 10:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbTDVO53
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 10:57:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:11742
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263191AbTDVO52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 10:57:28 -0400
Subject: Re: Linux 2.4.21-rc1 : aic7xxx deadlock on boot on my machine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: eric.valette@free.fr,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304221036.19274.m.c.p@wolk-project.de>
References: <3EA4FF4C.2030702@free.fr>
	 <200304221036.19274.m.c.p@wolk-project.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051020692.14881.12.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Apr 2003 15:11:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-22 at 09:36, Marc-Christian Petersen wrote:
> > So I hope, it will be updated in rc2...
> I'll _bet_ that the new well good code from Justin won't make it into 2.4 
> earlier than 2.4.22-pre1.

Its not the good code that worries me - its what bits of it turn out to
be buggy

