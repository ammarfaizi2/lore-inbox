Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbTINR0i (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTINR0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:26:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12776 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261221AbTINR0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:26:36 -0400
Message-ID: <3F64A4BD.6030906@pobox.com>
Date: Sun, 14 Sep 2003 13:26:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andries Brouwer <aebr@win.tue.nl>
CC: "J.A. Magallon" <jamagallon@able.es>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: libata update posted
References: <3F628DC7.3040308@pobox.com> <20030913205652.GA3478@werewolf.able.es> <20030913212849.GB21426@gtf.org> <20030914111225.A3371@pclin040.win.tue.nl>
In-Reply-To: <20030914111225.A3371@pclin040.win.tue.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries Brouwer wrote:
> This shows why defkeymap.c is not generated in the kernel build
> but distributed.

There is a difference between distributed generating files, and checking 
generated files into a repository...  I do not advocate changing the 
tarball, just the BK repo behind it.

	Jeff



