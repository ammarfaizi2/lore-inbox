Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbTEMAXj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 20:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTEMAXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 20:23:39 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:33964 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263013AbTEMAXc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 20:23:32 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Thomas Molina <tmolina@cox.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0305122001060.1159-100000@lap.molina>
References: <Pine.LNX.4.44.0305122001060.1159-100000@lap.molina>
Content-Type: text/plain
Message-Id: <1052786166.615.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.3 (Preview Release)
Date: 13 May 2003 02:36:06 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-05-13 at 04:07, Thomas Molina wrote:
> I'm back to testing with 2.5 and I am not having any issues with PCMCIA in 
> 2.5.69-bk.  I'm not using any additional patches.  System is Presario 
> 12XL325 with RedHat 8.0.  It has a Linksys PCMCIA card using the tulip 
> driver.

You'd better try with an -mm kernel. Vanilla and -bk kernels don't still
have Russell latest PCMCIA/CardBus patches.
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

