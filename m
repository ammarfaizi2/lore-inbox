Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268836AbTGTXLl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 19:11:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268893AbTGTXLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 19:11:41 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:64228
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S268836AbTGTXLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 19:11:41 -0400
Subject: Re: BUG in 2.4.21 ide-iops.c:1262
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Sobe <daniel.sobe@epost.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1058739880.1077.15.camel@localhost>
References: <1058739880.1077.15.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058743456.32464.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jul 2003 00:24:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-20 at 23:25, Daniel Sobe wrote:
> This happens when my TRAXDATA cd writer cannot read a disc which I
> either want to mount or play audio from. I do not know whether the
> hardware is flawed or there is really a bug in the kernel. My other
> drives do not produce this error.

Should be fixed for your setup in the 2.4.22pre latest

