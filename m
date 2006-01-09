Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWAIOUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWAIOUI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWAIOUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:20:08 -0500
Received: from mail.charite.de ([160.45.207.131]:6784 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S932180AbWAIOUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:20:06 -0500
Date: Mon, 9 Jan 2006 15:19:58 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/ide/ide.c:1384!
Message-ID: <20060109141958.GM2767@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060109095159.GE4535@charite.de> <1136816352.6659.10.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1136816352.6659.10.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk>:

> You should be able to reproduce it without the Nvidia code loaded if you
> do I/O on the disk and run hdparm -w in a tight loop while doing so.
> 
> You might want to do it on a disk you have a backup of

I think I'll pass :)
-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
