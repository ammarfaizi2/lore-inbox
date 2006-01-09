Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbWAIKGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWAIKGc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWAIKGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:06:32 -0500
Received: from mail.charite.de ([160.45.207.131]:16284 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S1751227AbWAIKGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:06:31 -0500
Date: Mon, 9 Jan 2006 11:06:28 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/ide/ide.c:1384!
Message-ID: <20060109100628.GA2767@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20060109095159.GE4535@charite.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060109095159.GE4535@charite.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> I invoked "hdparm -w /dev/hda"
> 
> # uname -a
> Linux hummus.charite.de 2.6.15 #1 Tue Jan 3 09:30:04 CET 2006 i686 GNU/Linux
> 
> Before you flame away at me for using the nvidia kernel module: I will
> reproduce this WITHOUT the nvidia kernel module. At least I'll try.

And alas, it doens't reproduce. I'll now crawl under a rock and be
ashamed of myself.

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
