Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbTIQJ4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262714AbTIQJzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:55:12 -0400
Received: from ms-1.rz.RWTH-Aachen.DE ([134.130.3.130]:33166 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S262724AbTIQJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:54:59 -0400
Date: Fri, 02 Nov 2001 10:53:39 +0000 (europe)
From: jarausch@belgacom.net
Subject: 2.4.14-pre7 Unresolved symbols
To: linux-kernel@vger.kernel.org
Reply-to: jarausch@belgacom.net
Message-id: <20030917095232.CC86AA7E68@numa-i.igpm.rwth-aachen.de>
MIME-version: 1.0
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to build 2.4.14-pre7 breaks with the error message
depmod: *** Unresolved symbols in /lib/modules/2.4.14-pre7/kernel/fs/romfs/romfs.o
depmod:         unlock_page

during make modules_install.

2.4.14-pre6 is running fine here.

Thank for hint,
Helmut Jarausch

Inst. of Technology
RWTH Aachen
Germany



