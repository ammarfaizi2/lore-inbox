Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267796AbTBKMmn>; Tue, 11 Feb 2003 07:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267799AbTBKMmn>; Tue, 11 Feb 2003 07:42:43 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:35590 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S267796AbTBKMmm>;
	Tue, 11 Feb 2003 07:42:42 -0500
To: Mike Anderson <andmike@us.ibm.com>
Cc: "Randy.Dunlap" <randy.dunlap@verizon.net>, linux-kernel@vger.kernel.org,
       james.bottomley@steeleye.com, campbell@torque.net
Subject: Re: [PATCH] scsi/imm.c compile errors in 2.5.60
References: <20030211083453.GA6787@beaverton.ibm.com>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <20030211083453.GA6787@beaverton.ibm.com>
Date: 11 Feb 2003 07:52:00 -0500
Message-ID: <m3znp3q8sv.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike> Randy, It looks good. I cc'd David Campbell the listed
Mike> maintainer of the driver just to let him know of the update.

scsi/ppa.c (iomega's other scsi-over-parallel protocol) probably needs
the same fix.

-JimC

