Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbUBHOQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 09:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUBHOQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 09:16:57 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:54157
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263620AbUBHOQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 09:16:57 -0500
Date: Sun, 8 Feb 2004 09:28:59 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: usb-storage in 2.6.2
Message-ID: <20040208092859.A30004@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that if I remove usb-storage and reinsert it, insmod will go
into D state and usb-storage will not work.  At this point, I can't shut
down the system normally since the shutdown will hang.

Is this a known problem?  The system is a supermicro X5DA8 board (E7505
Chipset).  I've had this problem with all 2.6 kernels.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
