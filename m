Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264433AbTDOLEI (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264434AbTDOLEI (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:04:08 -0400
Received: from c-97a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.151]:40577
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S264433AbTDOLEH (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 07:04:07 -0400
To: linux-kernel@vger.kernel.org
Subject: Writing modules for 2.5
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 15 Apr 2003 13:15:17 +0200
Message-ID: <yw1x7k9w9flm.fsf@zaphod.guide>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What magic needs to be done when writing modules for linux 2.5.x?
Insmod tells me "Invalid module format" and the kernel log says "No
module found in object".  I've tried to mimic the foo.mod.c stuff in
the kernel tree, but I can't figure out the right way to do it.

-- 
Måns Rullgård
mru@users.sf.net
