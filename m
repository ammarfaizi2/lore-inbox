Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCPSpk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbUCPSpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:45:40 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:3523 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261204AbUCPSph (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:45:37 -0500
Date: Tue, 16 Mar 2004 19:44:56 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: TLD.rmk.(none) junk in BitKeeper logs where BK_HOST belongs?
Message-ID: <20040316184455.GA31710@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

whose broken script or BitKeeper installation causes all these annoying
de.rmk.(none), au.rmk.(none) and all that to be logged instead of the
real BK_HOST?

The pattern seems to be the original TLD with 2nd level and below of the
domain stripped, plus .rmk.(none) appended.

I don't care to know who it is but would the offending system please be
updated or fixed?

Thanks in advance. Sample, 20 random incidents, one with full log:

ChangeSet@1.1608.65.2, 2004-03-05 20:41:31+00:00, laforge@org.rmk.(none)
  [SERIAL] Fix supprot for AFAVLAB 8port boards in 2.6.x
  
  I didn't yet use one of my AFAVLAB boards with 2.6.x until now.  The
  upper 4 ports are not detected at all.  I suppose the bug was
  introduced while porting the driver from 2.4.x.
  
  Please consider applying the following patch.  It also adds support
  for a new 8 port board called P030.

ChangeSet@1.1608.65.1, 2004-03-05 20:16:43+00:00, bjorn.helgaas@com.rmk.(none)
ChangeSet@1.1608.60.3, 2004-03-04 22:17:06+00:00, dsaxena@net.rmk.(none)
ChangeSet@1.1608.60.2, 2004-03-04 22:13:54+00:00, icampbell@com.rmk.(none)
ChangeSet@1.1608.60.1, 2004-03-04 22:13:37+00:00, dsaxena@net.rmk.(none)
ChangeSet@1.1608.19.1, 2004-02-26 12:15:46+00:00, armcc2000@com.rmk.(none)
ChangeSet@1.1588.4.4, 2004-02-22 17:16:19+00:00, mail@de.rmk.(none)
ChangeSet@1.1588.2.3, 2004-02-21 22:44:43+00:00, bjorn.helgaas@com.rmk.(none)
ChangeSet@1.1588.2.2, 2004-02-21 22:39:59+00:00, bjorn.helgaas@com.rmk.(none)
ChangeSet@1.1588.2.1, 2004-02-21 14:54:36+00:00, mark@net.rmk.(none)
ChangeSet@1.1557.70.117, 2004-02-20 19:24:06+00:00, dsaxena@net.rmk.(none)
ChangeSet@1.1557.86.1, 2004-02-20 16:52:31+00:00, h.schurig@de.rmk.(none)
ChangeSet@1.1557.70.116, 2004-02-20 10:09:26+00:00, tony@com.rmk.(none)
ChangeSet@1.1557.70.115, 2004-02-19 12:47:07+00:00, linux@de.rmk.(none2)
ChangeSet@1.1500.3.4, 2004-01-27 22:11:07+00:00, dirk.behme@com.rmk.(none)
ChangeSet@1.1500.3.3, 2004-01-27 22:07:35+00:00, fb.arm@net.rmk.(none)
ChangeSet@1.1500.3.2, 2004-01-27 22:04:31+00:00, fb.arm@net.rmk.(none)
ChangeSet@1.1500.3.1, 2004-01-27 22:01:27+00:00, fb.arm@net.rmk.(none)
ChangeSet@1.1474.101.10, 2004-01-20 22:26:42+00:00, fb.arm@net.rmk.(none)
ChangeSet@1.1474.101.9, 2004-01-20 22:24:14+00:00, nico@org.rmk.(none)

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
