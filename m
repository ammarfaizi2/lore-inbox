Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUAYBZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 20:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbUAYBZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 20:25:58 -0500
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:17301
	"EHLO animx.eu.org") by vger.kernel.org with ESMTP id S263178AbUAYBZ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 20:25:57 -0500
Date: Sat, 24 Jan 2004 20:36:46 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.1 dual xeon
Message-ID: <20040124203646.A8709@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently aquired a dual xeon system.  HT is enabled which shows up as 4
cpus.  I noticed that all interrupts are on CPU0.  Can anyone tell me why
this is?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
