Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262023AbTFDA0U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 20:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTFDA0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 20:26:20 -0400
Received: from air-2.osdl.org ([65.172.181.6]:20898 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262023AbTFDA0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 20:26:19 -0400
Subject: [KEXEC][2.5.70][ANNOUNCE] kexec for 2.5.70 available
From: Andy Pfiffer <andyp@osdl.org>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Eric Biederman <ebiederm@xmission.com>,
       Suparna Bhattacharya <suparna@in.ibm.com>, fastboot@osdl.org
Content-Type: text/plain
Organization: 
Message-Id: <1054687147.1267.8.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 03 Jun 2003 17:39:07 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A patch set for kexec for 2.5.70 is now available. This patch set is
based upon the stable 2.5.{67,68,69} versions of kexec. The most recent
set of kexec patches do not yet patch cleanly into 2.5.70. 

This patch was tested to work on a dual-proc P4-1.7GHz Xeon system. The
only known strangeness I have observed (YMMV) is that the VESA
framebuffer driver did not reinitialize correctly after kexec-ing a new
kernel, but the system rebooted correctly. 

The stable patches for 2.5.70 are available for download from OSDL's
patch life-cycle manager (PLM ) in pieces, or as a single unified patch.

More info here:
http://www.osdl.org/archive/andyp/bloom/Code/Linux/Kexec/index.html

