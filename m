Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265304AbTLGAUf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 19:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265305AbTLGAUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 19:20:35 -0500
Received: from legolas.restena.lu ([158.64.1.34]:12753 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S265304AbTLGAUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 19:20:30 -0500
Subject: Re: Catching NForce2 lockup with NMI watchdog - found?
From: Craig Bradney <cbradney@zip.com.au>
To: Ian Kumlien <pomac@vapor.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1070739194.1985.4.camel@big.pomac.com>
References: <1070739194.1985.4.camel@big.pomac.com>
Content-Type: text/plain
Message-Id: <1070756427.2093.2.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 07 Dec 2003 01:20:27 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-12-06 at 20:33, Ian Kumlien wrote:
> Hi, i'm now running this patch and it survived my grep in /usr/src.
> 
> It's mainly a correction of the apic patch and the ACPI halt disconnect
> patch that was originally done for 2.6...

Correction? how so? code looks the same, although the line numbers are
completely different for mpparse.c and at that location there is
different code. (Havent checked the disconnect)

Or do u just mean combination of the two patches?

> 
> I'll get back to you about uptime, but i think this is it... 

Why do you think the disconnect is also related? (given some are just
running the APIC patch and having (less/)no issues?
> 
> Although i would prefer a not so workaroundish approach =)

23 hrs now.. 

Craig

