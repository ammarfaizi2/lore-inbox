Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUAaGf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 01:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUAaGf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 01:35:59 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:40600 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263452AbUAaGf6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 01:35:58 -0500
Date: Sat, 31 Jan 2004 19:37:25 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Software Suspend 2.0
In-reply-to: <200401310622.17530.luke7jr@yahoo.com>
To: Luke-Jr <luke7jr@yahoo.com>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1075531042.18161.35.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1075436665.2086.3.camel@laptop-linux>
 <200401310622.17530.luke7jr@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-01-31 at 19:22, Luke-Jr wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Except that it doesn't seem to work...
> 1. patched in software-suspend-core-2.0-whole -- worked fine
> 2. software-suspend-linux-2.6.1-rev3-whole:
> 	2a. can't autodetect files to patch
> 	2b. alot of patching fails
> 
> Is there something obvious I'm doing wrong? :/

Yes. Apply the patches the other way around - the version specific one
first, then the core. Oh, you'll also want to get the latest 2.6.1 patch
(http://swsusp.sf.net).

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

