Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTD3K6C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 06:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTD3K6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 06:58:02 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:52355 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262013AbTD3K6B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 06:58:01 -0400
Subject: Re: [CFT] Fix PCMCIA deadlock (rev. 2)
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030429151750.B13439@flint.arm.linux.org.uk>
References: <20030429151750.B13439@flint.arm.linux.org.uk>
Content-Type: text/plain
Message-Id: <1051701006.597.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 30 Apr 2003 13:10:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-04-29 at 16:17, Russell King wrote:
> Ok, I think everyone ignored my last email about the updated pcmcia
> deadlock patch.  I've done a little more work on it since then, so
> here it is again.  Feedback welcome.

I did not ignore your mail ;-)
I'm now testing 2.5.68-mm3 which includes your latest PCMCIA fix. It's
working pretty well for me, as did previous versions.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

