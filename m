Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTEMN5Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 09:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbTEMN5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 09:57:16 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:51643 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261245AbTEMN5O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 09:57:14 -0400
Message-ID: <3EC0FC76.9010407@us.ibm.com>
Date: Tue, 13 May 2003 10:08:54 -0400
From: Stacy Woods <stacyw@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Bugs sitting in the RESOLVED state for more than 3 weeks
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These bugs have been sitting in RESOLVED state for more than three weeks,
ie, they have fixes, but aren't back in the mainline tree (when they
should move to CLOSED state). If the fixes are back in mainline
already, could the owner close them out? Otherwise, perhaps we
can get those fixes back in?

Kernel Bug Tracker: http://bugme.osdl.org

  24  File Sys   NFS        khoa@us.ibm.com
statfs returns incorrect  number fo blocks

  85  Drivers    Network    jgarzik@pobox.com
ham radio stuff still using cli etc

150  Drivers    PNP        ambx1@neo.rr.com
[PNP][2.5] IDE Detection problems (wrong IRQ and wrong IDE device number)

206  Drivers    Console/   jsimmons@infradead.org
broken colors on framebuffer console

282  Drivers    Other      hannal@us.ibm.com
tty drivers need to set .owner field

367  Platform   Alpha      rth@twiddle.net
modules fail to resolve illegal Unhandled relocation of type 10 for .text

372  Platform   UML        jdike@karaya.com
uml doesn't not compile

573  Drivers    I2C        greg@kroah.com
In function `via686a_attach_adapter':

