Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTJ0Oat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 09:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbTJ0Oat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 09:30:49 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30658 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263235AbTJ0Oas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 09:30:48 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Stefan Talpalaru <stefantalpalaru@yahoo.com>, andre@linux-ide.org
Subject: Re: CMD640 ide driver made to work
Date: Mon, 27 Oct 2003 15:35:35 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20031027122652.29090.qmail@web20605.mail.yahoo.com>
In-Reply-To: <20031027122652.29090.qmail@web20605.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310271535.35762.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Can you please drop all code-style changes (such as foo() -> foo ())
from your patch and describe what real changes you've done?
Also please fix your mailer, it breaks lines.

BTW Andre is no longer maintaing IDE, cc: me instead, thanks.

cheers,
--bartlomiej

On Monday 27 of October 2003 13:26, Stefan Talpalaru wrote:
> Hi Andre!
>
>   I own an old 486 box with a CMD640 chipset on it. It works just fine under
> the 2.2.x kernel, but not under the 2.4.x series. I modified the "cmd640"
> driver so it works and I have tested it on my hardware.
>   This patch is for the 2.4.22 kernel.

