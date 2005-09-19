Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932366AbVISHvE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbVISHvE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 03:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbVISHvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 03:51:04 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:45788 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932366AbVISHvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 03:51:01 -0400
Date: Mon, 19 Sep 2005 09:50:51 +0200
From: Pavel Machek <pavel@suse.cz>
To: Martin =?iso-8859-1?Q?v=2E_L=F6wis?= <martin@v.loewis.de>
Cc: Martin Mares <mj@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] Support UTF-8 scripts
Message-ID: <20050919075051.GG1893@elf.ucw.cz>
References: <4NsYH-4bv-27@gated-at.bofh.it> <4NtBr-4WU-3@gated-at.bofh.it> <4NtL0-5lQ-13@gated-at.bofh.it> <432B2C49.8080008@v.loewis.de> <20050917120123.GA3095@ucw.cz> <432C0B51.704@v.loewis.de> <20050919070820.GA2382@elf.ucw.cz> <432E6649.1070408@v.loewis.de> <20050919072446.GF1893@elf.ucw.cz> <432E6CC3.8000109@v.loewis.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <432E6CC3.8000109@v.loewis.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Po 19-09-05 09:46:11, "Martin v. Löwis" wrote:
> Pavel Machek wrote:
> > If UTF-8 compatibility is important, distros will get it right. If it
> > is not, you loose, but at least kernel is not messed up.
> 
> The patch doesn't mess up the kernel.

Every patch does.

Except that yours one does not because it is not going in :-).
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
