Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262919AbUCWXlh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:41:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUCWXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:41:36 -0500
Received: from mail.tpgi.com.au ([203.12.160.61]:38569 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S262919AbUCWXk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:40:56 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jonathan Sambrook <swsusp@hmmn.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040323233228.GK364@elf.ucw.cz>
References: <1079659165.15559.34.camel@calvin.wpcb.org.au>
	 <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz>
	 <200403231743.01642.dtor_core@ameritech.net>
	 <20040323233228.GK364@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080081653.22670.15.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 24 Mar 2004 10:40:53 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi yet again.

On Wed, 2004-03-24 at 11:32, Pavel Machek wrote:
> Well, I'd hate
> 
> Nov 10 00:37:51 amd kernel: Buffer I/O error on device sr0, logical block 842340
> Nov 10 00:37:53 amd kernel: end_request: I/O error, dev sr0, sector 6738472
> 
> to be obscured by progress bar.

So why aren't you arguing against bootsplash too? That definitely
obscures such an error :> Of course we could argue that such an error
shouldn't happen and/or will be obvious via other means (assuming it
indicates hardware failure).

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

