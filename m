Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbTLULsE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 06:48:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262674AbTLULsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 06:48:04 -0500
Received: from ns1.skjellin.no ([80.239.42.66]:46563 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262747AbTLULsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 06:48:02 -0500
Subject: Re: 3ware driver broken with 2.4.22/23 ?
From: Andre Tomt <lkml@tomt.net>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031221112113.GE916@mail.muni.cz>
References: <20031221112113.GE916@mail.muni.cz>
Content-Type: text/plain
Message-Id: <1072007285.1088.223.camel@slurv.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 12:48:06 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-21 at 12:21, Lukas Hejtmanek wrote:
> Hello,
> 
> I have 3ware Escalade 8500-8 card with 8 SATA WD 250GB drives. I set up HW RAID5
> configuration over all drives.
> I'm using kernel 2.4.23 vanilla with XFS patch. RAID5 partition is formated to
> XFS.

Reproducing with a different filesystem would probably be a useful
datapoint.


