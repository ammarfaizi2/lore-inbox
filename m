Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265077AbTBKPrq>; Tue, 11 Feb 2003 10:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265196AbTBKPrq>; Tue, 11 Feb 2003 10:47:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33205 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265077AbTBKPrp>;
	Tue, 11 Feb 2003 10:47:45 -0500
Date: Tue, 11 Feb 2003 07:54:47 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
Cc: andmike@us.ibm.com, randy.dunlap@verizon.net, linux-kernel@vger.kernel.org,
       james.bottomley@steeleye.com, campbell@torque.net
Subject: Re: [PATCH] scsi/imm.c compile errors in 2.5.60
Message-Id: <20030211075447.1fa7b98e.rddunlap@osdl.org>
In-Reply-To: <m3znp3q8sv.fsf@lugabout.jhcloos.org>
References: <20030211083453.GA6787@beaverton.ibm.com>
	<m3znp3q8sv.fsf@lugabout.jhcloos.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 Feb 2003 07:52:00 -0500
"James H. Cloos Jr." <cloos@jhcloos.com> wrote:

| Mike> Randy, It looks good. I cc'd David Campbell the listed
| Mike> maintainer of the driver just to let him know of the update.
| 
| scsi/ppa.c (iomega's other scsi-over-parallel protocol) probably needs
| the same fix.

Yes, I was planning to go thru drivers/scsi/ looking for others
that need this repair.

--
~Randy
