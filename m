Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262400AbVAUQ5I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbVAUQ5I (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 11:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVAUQ5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 11:57:08 -0500
Received: from relay.muni.cz ([147.251.4.35]:13003 "EHLO tirith.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262400AbVAUQ5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 11:57:03 -0500
Date: Fri, 21 Jan 2005 17:56:54 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-bk9 crash in mdadm
Message-ID: <20050121165654.GP3922@fi.muni.cz>
References: <20050121161230.GN3922@fi.muni.cz> <20050121162250.GQ25714@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121162250.GQ25714@marowsky-bree.de>
User-Agent: Mutt/1.4.1i
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
: On 2005-01-21T17:12:30, Jan Kasprzak <kas@fi.muni.cz> wrote:
: 
: > Just FWIW, I've got the following crash when trying to boot a 2.6.11-rc1-bk9
: > kernel on my dual opteron Fedora Core 3 box. I will try -bk8 now.
: 
: Attached is a likely candidate for a fix.
: 
: (It's been discussed on linux-raid already.)

	Yes, it makes 2.6.11-rc1-bk9 boot correctly on my box. Thanks!

-Y.

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
