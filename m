Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBFQC4>; Tue, 6 Feb 2001 11:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129063AbRBFQCr>; Tue, 6 Feb 2001 11:02:47 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:64009 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129051AbRBFQCQ>; Tue, 6 Feb 2001 11:02:16 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE005@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'lkml'" <linux-kernel@vger.kernel.org>
Subject: kernel param. Q's
Date: Tue, 6 Feb 2001 08:02:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Linux 2.4.0)

1.  Are the PARIDE options that are listed in
linux/Documentation/kernel-parameters.txt still valid?
I couldn't find them in drivers/block/paride anywhere.

2.  kernel-parameters.txt says (or implies to me) that
    ide?=nodma
is a valid kernel option.  However, I can't see this
parsed in drivers/block anywhere.  Anybody know if this
is (still) valid?

Thanks,
~Randy_________________________________________

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
