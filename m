Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263871AbUDPVtE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:49:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263855AbUDPVq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:46:26 -0400
Received: from outmx005.isp.belgacom.be ([195.238.2.102]:25824 "EHLO
	outmx005.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S263845AbUDPVpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:45:40 -0400
Subject: Ide special case
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1082152120.6120.3.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 23:48:41 +0200
Content-Transfer-Encoding: 7bit
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx005.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	I was looking at some IDE sources and I'm surprised to see a lot of
pdc4030 special cases even in high level sources....Is there a reason
for that ? (I dunno that hardware :( ).

Regards,
Fabian

