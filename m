Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263171AbTHBNG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 09:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbTHBNG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 09:06:29 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:56258 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263171AbTHBNG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 09:06:28 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sat, 2 Aug 2003 15:06:26 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre10
Message-Id: <20030802150626.01fd24d4.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
References: <Pine.LNX.4.44.0308011316490.3656-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Aug 2003 13:19:11 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> 
> Hello,
> 
> Here goes -pre10, hopefully the last -pre of 2.4.22. 

Have I missed something before, is this expected during build:

make[3]: Circular /usr/src/linux-2.4.22-pre10/include/asm/smplock.h <-
/usr/src/linux-2.4.22-pre10/include/linux/interrupt.h dependency dropped.

?

Regards,
Stephan


