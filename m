Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130230AbRAaVDD>; Wed, 31 Jan 2001 16:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129911AbRAaVCx>; Wed, 31 Jan 2001 16:02:53 -0500
Received: from 3ff8be8d.dsl.flashcom.net ([63.248.190.141]:4612 "EHLO
	vader.supremedesigns.com") by vger.kernel.org with ESMTP
	id <S130163AbRAaVCs>; Wed, 31 Jan 2001 16:02:48 -0500
Message-ID: <3A787D97.CBF7B327@supremedesigns.com>
Date: Wed, 31 Jan 2001 16:03:19 -0500
From: Lukasz Gogolewski <lucas@supremedesigns.com>
Organization: SupremeDesigns
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: problems with sblive as well as 3com 3c905
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After I compiled kernel 2.4.1 on rh 6.2 I enabled module support for 2
of those devices.

However when I rebooted my machine both of those devices are not
working.

I don't know what's wrong since I did make moudle and make
module_install.

When I try to configure mdoule for the sound card, I get a message
saying that module wasn't found.

For the network card I get Delaying initialization

any suggestions on how to fix it?

- Lucas





-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
