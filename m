Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932701AbVKBJtR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932701AbVKBJtR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:49:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932702AbVKBJtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:49:16 -0500
Received: from denise.shiny.it ([194.20.232.1]:17832 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S932701AbVKBJtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:49:16 -0500
Message-ID: <XFMail.20051102104916.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <5449aac20511011246r6ece9f18rb3b7353dbfc2dedb@mail.gmail.com>
Date: Wed, 02 Nov 2005 10:49:16 +0100 (CET)
From: Giuliano Pochini <pochini@shiny.it>
To: alex@alexfisher.me.uk
Subject: Re: Would I be violating the GPL?
Cc: linux-kernel@vger.kernel.org, "Jeff V. Merkey" <jmerkey@utah-nac.org>,
       Michael Buesch <mbuesch@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01-Nov-2005 Alexander Fisher wrote:

> I've got the source code to the device firmware too.

Maybe they only care on keeping the firmware secret. Try asking
them if you can disclose the driver sources only. The firmware
can be used in binary form.


> So despite the fact the driver has been written in c++, it
> might be possible to write a usable specification.

Linux 2.6 doesn't accept c++, so you have to rewrite it anyway.
You should ask them if you can publish your own driver based
on infos you extract from their driver.


--
Giuliano.
