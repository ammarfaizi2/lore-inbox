Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264137AbTDPV77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 17:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264418AbTDPV77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 17:59:59 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:35200
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264137AbTDPV77
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 17:59:59 -0400
To: andre@linux-ide.org
Cc: linux-kernel@vger.kernel.org
Subject: HPT374 performs badly in 2.5.67
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 17 Apr 2003 00:10:19 +0200
Message-ID: <yw1xadeqjdpw.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My disks connected to a hpt374 controller are a lot slower in linux
2.5.67 than 2.4.21-pre5.  Under 2.4 I get ~40 MB/s (as expected), but
with 2.5.67 the rates drop to ~30 MB/s.

The system is an Alpha SX164.  Disks are one Western Digital WD880BB,
and one Seagate Barracuda V 120GB.

Is there any explanation, or (better) fix, for this degradation?

-- 
Måns Rullgård
mru@users.sf.net
