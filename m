Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265027AbUHMMVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265027AbUHMMVw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUHMMVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:21:52 -0400
Received: from cantor.suse.de ([195.135.220.2]:1999 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265027AbUHMMVv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:21:51 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: davidsen@tmr.com, timw@splhi.com, James.Bottomley@steeleye.com,
       axboe@suse.de, linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408131145.i7DBjGkS023641@burner.fokus.fraunhofer.de>
From: Andreas Schwab <schwab@suse.de>
X-Yow: I OWN six pink HIPPOS!!
Date: Fri, 13 Aug 2004 14:21:48 +0200
In-Reply-To: <200408131145.i7DBjGkS023641@burner.fokus.fraunhofer.de> (Joerg
 Schilling's message of "Fri, 13 Aug 2004 13:45:16 +0200 (CEST)")
Message-ID: <jellgjdy8z.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling <schilling@fokus.fraunhofer.de> writes:

> Install Solaris and try to replug a USB writer - you will see the same
> address as before.

What happens when you unplug the USB writer, plug in a different one and
then replug the first writer?

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
