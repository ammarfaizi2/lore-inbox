Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVAMRsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVAMRsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbVAMRXd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:23:33 -0500
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:64450 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S261290AbVAMRUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:20:53 -0500
Date: Fri, 02 Nov 2001 10:53:39 +0000 (europe)
From: jarausch@belgacom.net
Subject: 2.4.14-pre7 Unresolved symbols
To: linux-kernel@vger.kernel.org
Reply-to: jarausch@belgacom.net
Message-id: <20050113151054.A3FFCFEC12@numa-i.igpm.rwth-aachen.de>
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



