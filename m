Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUCXVo7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbUCXVo7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:44:59 -0500
Received: from outmx017.isp.belgacom.be ([195.238.2.116]:38847 "EHLO
	outmx017.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262029AbUCXVo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:44:56 -0500
Subject: root_plug questions under 2.6.5rc2-mm2
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080164662.3033.9.camel@linux.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 24 Mar 2004 22:44:22 +0100
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx017.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	When trying 'modprobe root_plug vendor_id=xxxx product_id=yyyy' on a
workable usb storage device, I get all commands locked (which should
appear when I remove it) ... I also get 'cannot execute /sbin/mingetty'
from new console login tries then 'respawning too fast, disabled for 5
minutes' ....

Someone could help me ?

PS :I'm not subscribed to lkml.

Regards,
Fabian

