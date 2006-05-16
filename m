Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751177AbWEPOmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbWEPOmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 10:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEPOmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 10:42:05 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:62643 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1751175AbWEPOmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 10:42:04 -0400
Message-ID: <4469E51E.80103@cmu.edu>
Date: Tue, 16 May 2006 10:43:42 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problem booting 2.4.32, unknown symbol
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to boot 2.4.32 with FC3, whenever i try to boot i get the
following errors:

insmod: error inserting `/lib/scsi_mod.o': -1 Unknown symbol in module
ERROR /bin/insmod excited abnormally!
insmod: error inserting `/lib/sd_mod.o': -1 Unknown symbol in module

I get the same error for libata.o, ata_piix.o, and lvm-mod.o

then i get failed to create /edv/ide/host0/bus0/target0/lun0/disc

So my guess is trying to fix the top most first

Anyone have any ideas?

Thanks!
George
