Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265943AbUIDTxP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265943AbUIDTxP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 15:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265974AbUIDTxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 15:53:15 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:43222 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265943AbUIDTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 15:53:14 -0400
Subject: sleep and wakeup at microsecond boundary
From: "NucleoDyne Systems, " "Inc." <nucleon@nucleodyne.com>
Reply-To: nucleon@nucleodyne.com
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: NucleoDyne Corporation
Message-Id: <1094327496.3422.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 04 Sep 2004 12:51:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
      We have a requirement to implement the sleep and wakeup mechanism
at microsecond boundary in 2.4 kernel. The intent of this mail is to
start a discussion on this topic and collect inputs from the kernel
developers. Any reply on the issues of implementing such a feature will
be greatly appreciated.

Thanks,
Kallol Biswas

-- 
--
NucleoDyne Corporation
nucleon@nucleodyne.com
www.nucleodyne.com
Phone:408-718-8164
Fax: 408-732-2284

