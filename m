Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUAMSLX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 13:11:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbUAMSLX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 13:11:23 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:34953
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S264506AbUAMSLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 13:11:21 -0500
Date: Tue, 13 Jan 2004 13:23:37 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: USB mouse jumpy on 2.6.x
Message-ID: <20040113132337.E15725@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tested 2.6.x on 3 systems.  Only one of those exibit this problem. 
The system is a dual pIII 1ghz with 1024mb ram (kernel configured for 4gb
support).  The board is a supermicro p3tdde.  the other 2 systems are hp
compaq d220 pc and an MSI MS6163.  I am using the builtin ports on all
systems.

The p3dde works flawlessly with 2.4.23.

The one thing I see is the fact that the p3tdde uses a via chipset instead
of intel like the other 2 (and has more memory and 2 cpus)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
