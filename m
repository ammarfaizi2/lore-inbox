Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbUDLOr1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 10:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUDLOr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 10:47:26 -0400
Received: from outmx014.isp.belgacom.be ([195.238.2.69]:34781 "EHLO
	outmx014.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262142AbUDLOr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 10:47:26 -0400
Subject: NFS umount
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1081781374.5620.4.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 12 Apr 2004 16:49:34 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx014.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I was looking at NFS source code and I can't find where the umount
takes place in server side.... It seems nfsd/export.c has some functions
for that, but I added debugging there and nothing happens when umounting
from client/side.Someone could help me ? I read about some rpc.umountd
but was unable to find it on my system ...


Regards,
Fabian

