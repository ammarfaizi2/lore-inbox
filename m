Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265876AbTL3RWX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 12:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265877AbTL3RWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 12:22:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:35761 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265876AbTL3RWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 12:22:22 -0500
Message-ID: <3FF1B43A.9090707@pobox.com>
Date: Tue, 30 Dec 2003 12:22:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karel Kulhavy <clock@atrey.karlin.mff.cuni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: ICH5 docs
References: <20031230164953.GB4868@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20031230164953.GB4868@atrey.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karel Kulhavy wrote:
> Where can I learn about ICH5 SATA RAID driver in Linux kernel 2.6.0?  I


Intel "RAID" is software RAID.  There isn't any hardware RAID assist...

So ICH5 looks pretty much just like any other PATA host controller.

	Jeff



