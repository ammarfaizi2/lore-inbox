Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbUAEMJQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 07:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUAEMJQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 07:09:16 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:35502 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264155AbUAEMJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 07:09:14 -0500
Subject: Re: Kernel panic.. in 3.0 Enterprise Linux
From: Christophe Saout <christophe@saout.de>
To: neel vanan <neelvanan@yahoo.com>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040105115610.49148.qmail@web9505.mail.yahoo.com>
References: <20040105115610.49148.qmail@web9505.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1073304533.5562.7.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Jan 2004 13:08:54 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo, den 05.01.2004 schrieb neel vanan um 12:56:

> VFS cannot open root device "LABEL=/" or unknown block
> (0,0)
> Please append a correct "root=" boot option
> Kernel panic: VFS: Unable to mount root fs on
> unknown-block(0,0)

LABEL= is a RedHat extension. Please use the normal root options that is
described in the Grub or kernel documentation.


