Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbUCPBtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263324AbUCPBtl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:49:41 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:50620
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263428AbUCPBr3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:47:29 -0500
Date: Mon, 15 Mar 2004 20:56:50 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: deactivate dm disks?
Message-ID: <20040315205650.A11865@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was playing with evms (2.2 kernel 2.6.3 vanilla) and some reason, it
grabbed my usb disk (sde) and won't let go of it.  Is there any way I can
make it let go of the disk?  It grabbed sde1 and sde2 of the disk.

I tried the deactivate which just gave me an invalid argument. I really do
not wish to reboot this machine just to remove the usb disk.

I also noticed it wanted to grab my partitions on sda which were already
mounted and couldn't grab them.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
