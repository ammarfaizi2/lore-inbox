Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263107AbUEKScJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUEKScJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 14:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUEKScI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 14:32:08 -0400
Received: from adsl-static-1-36.uklinux.net ([62.245.36.36]:24530 "EHLO
	bristolreccc.co.uk") by vger.kernel.org with ESMTP id S263107AbUEKScA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 14:32:00 -0400
Subject: problem with sis900 driver 2.6.5 +
From: mike <mike@bristolreccc.co.uk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 May 2004 19:28:24 +0100
Message-Id: <1084300104.24569.8.camel@datacontrol>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernels 2.6.5 and above (may affect 2.6.4 as well) there seems to be
a problem with the sis900 eth driver

I have a sis chipset with integrated ethernet sis900 driver which has
always worked perfectly up to and including 2.6.3 (fedora)

Now with both fedora 2.6.5 kernel and vanilla 2.6.6 eth0 does not come
up

relevant messages

sis900 device eth0 does not appear to be present delaying initialisation

and from dmesg eth0: cannot find ISA bridge

2.6.3 works fine

lsmod shows sis and sis900 modules loaded fine
 
