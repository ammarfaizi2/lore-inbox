Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTJ0WKP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 17:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263639AbTJ0WKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 17:10:15 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25033 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263633AbTJ0WKK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 17:10:10 -0500
Message-ID: <3F9D97B3.2050406@pobox.com>
Date: Mon, 27 Oct 2003 17:09:55 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arve Knudsen <aknuds-1@broadpark.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6t9 SATA slower than 2.4.20
References: <3F9D402F.9050509@savages.net> <20031027165916.GE19711@gtf.org> <oprxppvbgvq1sf88@mail.broadpark.no> <20031027181529.GA5335@gtf.org> <oprxpz0wriq1sf88@mail.broadpark.no>
In-Reply-To: <oprxpz0wriq1sf88@mail.broadpark.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arve Knudsen wrote:
> Ok, thanks. So I might be better off with the older driver for now? From 
> what I remember Andre Hedrick was promising a fix?


Yes.  Until CONFIG_BROKEN marker is removed, I recommend the older 
Silicon Image driver in drivers/ide.

	Jeff



