Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751134AbWDUJey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751134AbWDUJey (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 05:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751147AbWDUJey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 05:34:54 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:50385 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751134AbWDUJex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 05:34:53 -0400
Date: Fri, 21 Apr 2006 11:34:51 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: DM-Crypt <dm-crypt@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Crypto Hardware Accelerator
Message-ID: <20060421093451.GD21627@cip.informatik.uni-erlangen.de>
Mail-Followup-To: DM-Crypt <dm-crypt@saout.de>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,
I am looking for a crypto hardware accelerator which is available in the
EU in form of a PCI card which is supported by the linux kernel to do a
device mapper crypt setup using aes256. It would be also nice if it
could also be used by openssl userland applications. Also I would like
to know if there are some plans to support IDE drives which do AES
transparently for the OS. Like an ATA Command which tells the drive
which AES key to use during startup. An the rest does the device instead
of the hostos/cpu.

        Thomas
