Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbUA3Lsa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 06:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbUA3Lsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 06:48:30 -0500
Received: from gateway.set-software.de ([193.218.212.121]:30381 "EHLO
	gateway.local.net") by vger.kernel.org with ESMTP id S263513AbUA3Ls3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 06:48:29 -0500
From: Michael Knigge <Michael.Knigge@set-software.de>
Date: Fri, 30 Jan 2004 11:44:43 GMT
Message-ID: <20040130.11444335@knigge.local.net>
Subject: Re: Errors with USB Disk
To: Markus Schaber <schabios@logi-track.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040130122324.7ac7ef34.schabios@logi-track.com>
References: <20040130122324.7ac7ef34.schabios@logi-track.com>
X-Mailer: Mozilla/3.0 (compatible; StarOffice/5.1; Win32)
X-Priority: 3 (Normal)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm trying to use an USB Disk (IDE Disk in external USB Case), but
> strange file system errors occurend and tools as dosfsck reproducably
> hang.

Try/Read this:

http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg
18528.html


On my System, changing max_sectors to 128 doesn't help reliably. I'm 
currently testing if 64/32/16/8 will work better.


Bye
  Michael



