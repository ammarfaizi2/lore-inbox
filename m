Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261868AbTEEAyw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 20:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbTEEAyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 20:54:52 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:43953 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261868AbTEEAyv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 20:54:51 -0400
Subject: Re: will be able to load new kernel without restarting?
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Gabe Foobar <foobar.gabe@freemail.hu>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <freemail.20030403212422.18231@fm9.freemail.hu>
References: <freemail.20030403212422.18231@fm9.freemail.hu>
Content-Type: text/plain
Message-Id: <1052096831.1699.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 05 May 2003 03:07:11 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-05-03 at 21:24, Gabe Foobar wrote:
> Hi!
> 
> Just a simple question. When I will be able to load new
> kernel without restarting the system? Working anybody on
> this problem?

There's an experimental Linux kernel patch called "kexec" that allows
you to load another kernel (not only a Linux kernel) witout rebooting in
the sense of what this term really means: e.g. you can load another
Linux kernel without doing a full POST using the BIOS.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

