Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263980AbTE0R3x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 13:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263982AbTE0R3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 13:29:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:15566
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263980AbTE0R3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 13:29:52 -0400
Subject: Re: [patch] sis650 irq router fix for 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>,
       Martin Diehl <lists@mdiehl.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
References: <3ED21CE3.9060400@winischhofer.net>
	 <Pine.LNX.4.55.0305261431230.3000@bigblue.dev.mcafeelabs.com>
	 <3ED32BA4.4040707@winischhofer.net>
	 <Pine.LNX.4.55.0305271000550.2340@bigblue.dev.mcafeelabs.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054053901.18814.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 27 May 2003 17:45:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm keeping an eye on it. The correct answer appears to be 
"use ACPI" once it works on SiS

I'll probably try some of those changes in a later -ac and see what
happens

