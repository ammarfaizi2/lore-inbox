Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTHFOOF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 10:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTHFOOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 10:14:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:18637 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263355AbTHFOOA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 10:14:00 -0400
Date: Wed, 6 Aug 2003 07:18:57 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise
To: Pavel Machek <pavel@ucw.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PM] Unbreak S3
In-Reply-To: <20030806103702.GA701@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0308060718450.23977-100000@cherise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> SOFTWARE_SUSPEND/ACPI_SLEEP split was not ideal. As ACPI_SLEEP is now
> independant, #ifdef is wrong. Please apply,

Thanks, both applied.


	-pat

