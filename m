Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275222AbTHAM2x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 08:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275223AbTHAM2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 08:28:53 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:63761 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S275222AbTHAM2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 08:28:52 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give us an info about which one was killed
Date: Fri, 1 Aug 2003 14:26:13 +0200
User-Agent: KMail/1.5.2
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, vda@port.imtp.ilyichevsk.odessa.ua
References: <200307312254.16964.m.c.p@wolk-project.de> <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200308011425.29058.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 August 2003 14:09, Alan Cox wrote:

Hi Alan,

> This is potentially private information. It shouldnt be reported
> I disagree with the patch
well, it get logged to syslog(3) and dmesg(8). No normal user has access to 
it, no?

ciao, Marc

